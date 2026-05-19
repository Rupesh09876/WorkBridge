<%@ page import="com.workbridge.model.User" %>
<%@ page session="true" %>
<%
  User user = (User) session.getAttribute("loggedInUser");
  if (user == null) {
    // Not logged in → show the public landing page
    request.getRequestDispatcher(
      "/WEB-INF/views/landing.jsp"
    ).forward(request, response);
    return;
  }
  // Logged in → redirect to role dashboard
  String ctx = request.getContextPath();
  switch (user.getRole().name()) {
    case "ADMIN":
      response.sendRedirect(ctx + "/admin?action=dashboard");
      break;
    case "EMPLOYER":
      response.sendRedirect(ctx + "/employer?action=dashboard");
      break;
    default:
      response.sendRedirect(ctx + "/jobseeker?action=dashboard");
  }
%>
