package com.workbridge.controller;

import com.workbridge.dao.SavedJobDAO;
import com.workbridge.exception.ValidationException;
import com.workbridge.exception.WorkBridgeException;
import com.workbridge.model.JobSeekerProfile;
import com.workbridge.model.JobType;
import com.workbridge.model.User;
import com.workbridge.model.UserRole;
import com.workbridge.service.ApplicationService;
import com.workbridge.service.JobService;
import com.workbridge.service.ProfileService;
import com.workbridge.util.InputValidator;
import com.workbridge.util.SessionUtil;
import com.workbridge.service.NotificationService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * JobSeekerServlet — Controller for job seeker specific actions.
 *
 * <p>Handles job searching, saving jobs, managing profile, and applying.</p>
 *
 * @author WorkBridge Team
 * @version 1.0
 */
@WebServlet("/jobseeker")
public class JobSeekerServlet extends HttpServlet {

    private final JobService jobService = new JobService();
    private final ProfileService profileService = new ProfileService();
    private final ApplicationService applicationService = new ApplicationService();
    private final SavedJobDAO savedJobDAO = new SavedJobDAO();
    private final NotificationService notificationService = new NotificationService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            HttpSession session = request.getSession(false);
            if (!SessionUtil.requireRole(session, response, request, UserRole.JOB_SEEKER)) return;

            User user = SessionUtil.getUser(session);
            String action = request.getParameter("action");
            if (action == null) action = "dashboard";

            switch (action) {
                case "createProfile":
                    if (profileService.jobSeekerProfileExists(user.getId())) {
                        response.sendRedirect(request.getContextPath() + "/jobseeker?action=editProfile");
                    } else {
                        request.getRequestDispatcher("/WEB-INF/views/jobseeker/createProfile.jsp").forward(request, response);
                    }
                    break;
                case "editProfile":
                    JobSeekerProfile profile = profileService.getJobSeekerProfile(user.getId());
                    if (profile == null) {
                        response.sendRedirect(request.getContextPath() + "/jobseeker?action=createProfile");
                    } else {
                        request.setAttribute("profile", profile);
                        request.getRequestDispatcher("/WEB-INF/views/jobseeker/editProfile.jsp").forward(request, response);
                    }
                    break;
                case "search":
                    String keyword = InputValidator.sanitize(request.getParameter("keyword"));
                    String location = InputValidator.sanitize(request.getParameter("location"));
                    String typeStr = request.getParameter("jobType");
                    JobType type = InputValidator.isNotEmpty(typeStr) ? JobType.fromString(typeStr) : null;
                    int categoryId = 0;
                    try {
                        if (InputValidator.isNotEmpty(request.getParameter("categoryId"))) {
                            categoryId = Integer.parseInt(request.getParameter("categoryId"));
                        }
                    } catch (NumberFormatException ignored) {}

                    request.setAttribute("categories", jobService.getAllCategories());
                    request.setAttribute("jobs", jobService.searchJobs(keyword, location, type, categoryId));
                    request.getRequestDispatcher("/WEB-INF/views/jobseeker/searchJobs.jsp").forward(request, response);
                    break;
                case "jobDetail":
                    int jobId = Integer.parseInt(request.getParameter("id"));
                    request.setAttribute("job", jobService.getJobById(jobId));
                    request.setAttribute("isSaved", savedJobDAO.isSaved(user.getId(), jobId));
                    // Basic check for existing application
                    request.setAttribute("applications", applicationService.getApplicationsByApplicant(user.getId()));
                    request.getRequestDispatcher("/WEB-INF/views/jobseeker/jobDetails.jsp").forward(request, response);
                    break;
                case "myApplications":
                    request.setAttribute("applications", applicationService.getApplicationsByApplicant(user.getId()));
                    request.getRequestDispatcher("/WEB-INF/views/jobseeker/myApplications.jsp").forward(request, response);
                    break;
                case "savedJobs":
                    request.setAttribute("savedJobs", savedJobDAO.findByUser(user.getId()));
                    request.getRequestDispatcher("/WEB-INF/views/jobseeker/savedJobs.jsp").forward(request, response);
                    break;
                case "dashboard":
                default:
                    JobSeekerProfile dashboardProfile = profileService.getJobSeekerProfile(user.getId());
                    if (dashboardProfile == null) {
                        request.setAttribute("profileIncomplete", true);
                    } else {
                        int completionPct = profileService.getProfileCompletionPercent(dashboardProfile);
                        request.setAttribute("profileCompletion", completionPct);
                    }
                    request.setAttribute("latestJobs", jobService.getAllOpenJobs()); // Simplification for dashboard
                    request.setAttribute("recentApplications", applicationService.getApplicationsByApplicant(user.getId()));
                    request.getRequestDispatcher("/WEB-INF/views/jobseeker/dashboard.jsp").forward(request, response);
                    break;
            }
        } catch (WorkBridgeException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/common/error.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "An unexpected error occurred. Please try again.");
            request.getRequestDispatcher("/WEB-INF/views/common/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            HttpSession session = request.getSession(false);
            if (!SessionUtil.requireRole(session, response, request, UserRole.JOB_SEEKER)) return;

            if (!SessionUtil.validateCsrfToken(session, request)) {
                response.sendError(403, "Invalid CSRF token");
                return;
            }

            User user = SessionUtil.getUser(session);
            String action = request.getParameter("action");

            switch (action) {
                case "createProfile":
                case "editProfile":
                    JobSeekerProfile p = new JobSeekerProfile();
                    p.setUserId(user.getId());
                    p.setHeadline(InputValidator.sanitize(request.getParameter("headline")));
                    p.setSummary(InputValidator.sanitize(request.getParameter("summary")));
                    p.setSkills(InputValidator.sanitize(request.getParameter("skills")));
                    p.setEducation(InputValidator.sanitize(request.getParameter("education")));
                    p.setExperience(InputValidator.sanitize(request.getParameter("experience")));
                    p.setResumeUrl(InputValidator.sanitize(request.getParameter("resumeUrl")));
                    p.setLocation(InputValidator.sanitize(request.getParameter("location")));
                    p.setPhone(InputValidator.sanitize(request.getParameter("phone")));
                    p.setLinkedinUrl(InputValidator.sanitize(request.getParameter("linkedinUrl")));

                    if (!InputValidator.isNotEmpty(p.getHeadline())) {
                        throw new ValidationException("Headline is required.");
                    }

                    if ("createProfile".equals(action)) {
                        profileService.createJobSeekerProfile(p);
                        notificationService.notify(user.getId(), "Profile created successfully.");
                    } else {
                        profileService.updateJobSeekerProfile(p);
                        notificationService.notify(user.getId(), "Profile updated successfully.");
                    }
                    response.sendRedirect(request.getContextPath() + "/jobseeker?action=dashboard");
                    break;

                case "apply":
                    int jobId = Integer.parseInt(request.getParameter("jobId"));
                    String coverLetter = InputValidator.sanitize(request.getParameter("coverLetter"));
                    String resumeUrl = InputValidator.sanitize(request.getParameter("resumeUrl"));

                    applicationService.apply(jobId, user.getId(), coverLetter, resumeUrl);
                    response.sendRedirect(request.getContextPath() + "/jobseeker?action=myApplications");
                    break;

                case "withdraw":
                    int appId = Integer.parseInt(request.getParameter("applicationId"));
                    applicationService.withdrawApplication(appId, user.getId());
                    response.sendRedirect(request.getContextPath() + "/jobseeker?action=myApplications");
                    break;

                case "save":
                    int sJobId = Integer.parseInt(request.getParameter("jobId"));
                    savedJobDAO.save(user.getId(), sJobId);
                    notificationService.notify(user.getId(), "Job saved successfully.");
                    response.sendRedirect(request.getHeader("Referer"));
                    break;

                case "unsave":
                    savedJobDAO.unsave(user.getId(), Integer.parseInt(request.getParameter("jobId")));
                    response.sendRedirect(request.getHeader("Referer"));
                    break;

                default:
                    response.sendRedirect(request.getContextPath() + "/jobseeker?action=dashboard");
            }
        } catch (ValidationException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/common/error.jsp").forward(request, response);
        } catch (WorkBridgeException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/common/error.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "An unexpected error occurred. Please try again.");
            request.getRequestDispatcher("/WEB-INF/views/common/error.jsp").forward(request, response);
        }
    }
}
