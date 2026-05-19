package com.workbridge.controller;

import com.workbridge.exception.WorkBridgeException;
import com.workbridge.model.JobCategory;
import com.workbridge.model.JobListing;
import com.workbridge.model.JobType;
import com.workbridge.service.JobService;
import com.workbridge.util.InputValidator;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

/**
 * PublicJobServlet — handles public job browsing for unauthenticated
 * visitors. No login required. Allows anyone to browse open job
 * listings and filter by keyword, location, category, and job type.
 *
 * @author WorkBridge Team
 * @version 1.0
 */
@WebServlet("/jobs")
public class PublicJobServlet extends HttpServlet {

    private final JobService jobService = new JobService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Step 1: Read optional filter params
            String keyword = InputValidator.sanitize(request.getParameter("keyword"));
            String location = InputValidator.sanitize(request.getParameter("location"));
            String jobTypeStr = request.getParameter("jobType");
            String catIdStr = request.getParameter("categoryId");
            
            JobType jobType = null;
            if (InputValidator.isNotEmpty(jobTypeStr)) {
                try {
                    jobType = JobType.valueOf(jobTypeStr);
                } catch (IllegalArgumentException ignored) {}
            }

            int categoryId = 0;
            if (InputValidator.isNotEmpty(catIdStr)) {
                try {
                    categoryId = Integer.parseInt(catIdStr);
                } catch (NumberFormatException ignored) {}
            }

            // Step 2: Load matching open jobs via JobService.searchJobs()
            List<JobListing> jobs = jobService.searchJobs(keyword, location, jobType, categoryId);

            // Step 3: Load all categories for filter dropdown
            List<JobCategory> categories = jobService.getAllCategories();

            // Step 4: Set request attributes
            request.setAttribute("jobs", jobs);
            request.setAttribute("categories", categories);
            request.setAttribute("keyword", keyword);
            request.setAttribute("location", location);
            request.setAttribute("jobType", jobTypeStr);
            request.setAttribute("categoryId", categoryId);

            // Step 5: Forward to WEB-INF/views/public/jobBoard.jsp
            request.getRequestDispatcher("/WEB-INF/views/public/jobBoard.jsp").forward(request, response);

        } catch (WorkBridgeException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/common/error.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "An unexpected error occurred. Please try again.");
            request.getRequestDispatcher("/WEB-INF/views/common/error.jsp").forward(request, response);
        }
    }
}
