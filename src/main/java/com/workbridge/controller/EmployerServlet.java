package com.workbridge.controller;

import com.workbridge.exception.ValidationException;
import com.workbridge.exception.WorkBridgeException;
import com.workbridge.model.ApplicationStatus;
import com.workbridge.model.EmployerProfile;
import com.workbridge.model.JobListing;
import com.workbridge.model.JobType;
import com.workbridge.model.User;
import com.workbridge.model.UserRole;
import com.workbridge.service.ApplicationService;
import com.workbridge.service.JobService;
import com.workbridge.service.ProfileService;
import com.workbridge.util.InputValidator;
import com.workbridge.util.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;

/**
 * EmployerServlet — Controller for employer-specific actions.
 *
 * <p>Handles job posting, profile management, and viewing applicants.</p>
 *
 * @author WorkBridge Team
 * @version 1.0
 */
@WebServlet("/employer")
public class EmployerServlet extends HttpServlet {

    private final JobService jobService = new JobService();
    private final ProfileService profileService = new ProfileService();
    private final ApplicationService applicationService = new ApplicationService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            HttpSession session = request.getSession(false);
            if (!SessionUtil.requireRole(session, response, request, UserRole.EMPLOYER)) return;

            User user = SessionUtil.getUser(session);
            String action = request.getParameter("action");
            if (action == null) action = "dashboard";

            switch (action) {
                case "createProfile":
                    if (profileService.employerProfileExists(user.getId())) {
                        response.sendRedirect(request.getContextPath() + "/employer?action=editProfile");
                    } else {
                        request.getRequestDispatcher("/WEB-INF/views/employer/createProfile.jsp").forward(request, response);
                    }
                    break;
                case "editProfile":
                    EmployerProfile profile = profileService.getEmployerProfile(user.getId());
                    if (profile == null) {
                        response.sendRedirect(request.getContextPath() + "/employer?action=createProfile");
                    } else {
                        request.setAttribute("profile", profile);
                        request.getRequestDispatcher("/WEB-INF/views/employer/editProfile.jsp").forward(request, response);
                    }
                    break;
                case "postJob":
                    request.setAttribute("categories", jobService.getAllCategories());
                    request.getRequestDispatcher("/WEB-INF/views/employer/postJob.jsp").forward(request, response);
                    break;
                case "editJob":
                    int jobId = Integer.parseInt(request.getParameter("id"));
                    JobListing job = jobService.getJobById(jobId);
                    if (job.getEmployerId() != user.getId()) {
                        throw new ValidationException("You do not have permission to edit this job.");
                    }
                    request.setAttribute("job", job);
                    request.setAttribute("categories", jobService.getAllCategories());
                    request.getRequestDispatcher("/WEB-INF/views/employer/editJob.jsp").forward(request, response);
                    break;
                case "myJobs":
                    request.setAttribute("jobs", jobService.getJobsByEmployer(user.getId()));
                    // Would typically attach application counts here
                    request.getRequestDispatcher("/WEB-INF/views/employer/myJobs.jsp").forward(request, response);
                    break;
                case "applicants":
                    int jId = Integer.parseInt(request.getParameter("jobId"));
                    request.setAttribute("applications", applicationService.getApplicationsForJob(jId, user.getId()));
                    request.getRequestDispatcher("/WEB-INF/views/employer/viewApplicants.jsp").forward(request, response);
                    break;
                case "dashboard":
                default:
                    if (!profileService.employerProfileExists(user.getId())) {
                        request.setAttribute("profileIncomplete", true);
                    }
                    request.setAttribute("jobs", jobService.getJobsByEmployer(user.getId()));
                    request.getRequestDispatcher("/WEB-INF/views/employer/dashboard.jsp").forward(request, response);
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
            if (!SessionUtil.requireRole(session, response, request, UserRole.EMPLOYER)) return;

            if (!SessionUtil.validateCsrfToken(session, request)) {
                response.sendError(403, "Invalid CSRF token");
                return;
            }

            User user = SessionUtil.getUser(session);
            String action = request.getParameter("action");

            switch (action) {
                case "createProfile":
                case "editProfile":
                    EmployerProfile p = new EmployerProfile();
                    p.setUserId(user.getId());
                    p.setCompanyName(InputValidator.sanitize(request.getParameter("companyName")));
                    p.setCompanyDescription(InputValidator.sanitize(request.getParameter("companyDescription")));
                    p.setIndustry(InputValidator.sanitize(request.getParameter("industry")));
                    p.setWebsiteUrl(InputValidator.sanitize(request.getParameter("websiteUrl")));
                    p.setLogoUrl(InputValidator.sanitize(request.getParameter("logoUrl")));
                    p.setLocation(InputValidator.sanitize(request.getParameter("location")));
                    try {
                        p.setFoundedYear(Integer.parseInt(request.getParameter("foundedYear")));
                    } catch (NumberFormatException ignored) {}

                    if (!InputValidator.isNotEmpty(p.getCompanyName())) {
                        throw new ValidationException("Company name is required.");
                    }

                    if ("createProfile".equals(action)) {
                        profileService.createEmployerProfile(p);
                    } else {
                        profileService.updateEmployerProfile(p);
                    }
                    response.sendRedirect(request.getContextPath() + "/employer?action=dashboard");
                    break;

                case "postJob":
                case "editJob":
                    JobListing job = new JobListing();
                    if ("editJob".equals(action)) {
                        job.setId(Integer.parseInt(request.getParameter("id")));
                    }
                    job.setTitle(InputValidator.sanitize(request.getParameter("title")));
                    job.setDescription(InputValidator.sanitize(request.getParameter("description")));
                    job.setRequirements(InputValidator.sanitize(request.getParameter("requirements")));
                    job.setLocation(InputValidator.sanitize(request.getParameter("location")));
                    job.setSalaryRange(InputValidator.sanitize(request.getParameter("salaryRange")));
                    try {
                        job.setCategoryId(Integer.parseInt(request.getParameter("categoryId")));
                        job.setJobType(JobType.fromString(request.getParameter("jobType")));
                        String deadlineStr = request.getParameter("deadline");
                        if (InputValidator.isNotEmpty(deadlineStr)) {
                            job.setDeadline(LocalDate.parse(deadlineStr));
                        }
                    } catch (DateTimeParseException | IllegalArgumentException e) {
                        throw new ValidationException("Invalid form data submitted.");
                    }

                    if ("postJob".equals(action)) {
                        String publishStatus = request.getParameter("publishStatus");
                        if (!"DRAFT".equals(publishStatus)) publishStatus = "OPEN";
                        job.setStatus(publishStatus);
                        // Assuming JobService.createJob handles this correctly
                        jobService.createJob(job, user.getId());
                    } else {
                        job.setEmployerId(user.getId()); // ensure correct owner
                        job.setStatus(request.getParameter("status"));
                        jobService.updateJob(job, user.getId());
                    }
                    response.sendRedirect(request.getContextPath() + "/employer?action=myJobs");
                    break;

                case "closeJob":
                    jobService.closeJob(Integer.parseInt(request.getParameter("id")), user.getId());
                    response.sendRedirect(request.getContextPath() + "/employer?action=myJobs");
                    break;

                case "deleteJob":
                    jobService.deleteJob(Integer.parseInt(request.getParameter("id")), user.getId());
                    response.sendRedirect(request.getContextPath() + "/employer?action=myJobs");
                    break;

                case "publishJob":
                    int pubJobId = Integer.parseInt(request.getParameter("jobId"));
                    jobService.updateJobStatus(pubJobId, "OPEN", user.getId());
                    response.sendRedirect(request.getContextPath() + "/employer?action=myJobs&success=published");
                    break;

                case "updateStatus":
                    int appId = Integer.parseInt(request.getParameter("applicationId"));
                    ApplicationStatus newStatus = ApplicationStatus.fromString(request.getParameter("status"));
                    applicationService.updateApplicationStatus(appId, newStatus, user.getId());
                    // Referer redirect or back to applicants
                    response.sendRedirect(request.getContextPath() + "/employer?action=applicants&jobId=" + request.getParameter("jobId"));
                    break;

                default:
                    response.sendRedirect(request.getContextPath() + "/employer?action=dashboard");
            }
        } catch (ValidationException e) {
            // Re-populate and show error
            request.setAttribute("error", e.getMessage());
            if (e.hasErrors()) {
                request.setAttribute("fieldErrors", e.getFieldErrors());
            }
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
