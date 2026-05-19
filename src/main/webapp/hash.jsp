<%@ page import="org.mindrot.jbcrypt.BCrypt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Database Fixer</title>
    <style>
        body { font-family: sans-serif; padding: 20px; line-height: 1.6; }
        code { background: #f4f4f4; padding: 5px; border-radius: 4px; }
        .box { border: 1px solid #ccc; padding: 15px; margin-top: 10px; background: #eef; }
    </style>
</head>
<body>
    <h2>Admin Password Fixer</h2>
    <%
        String password = "Admin@123";
        String hash = BCrypt.hashpw(password, BCrypt.gensalt(12));
    %>
    <p>The correct hash for <code>Admin@123</code> using your local library is:</p>
    <div class="box">
        <code><%= hash %></code>
    </div>
    
    <h3>SQL Command to fix your database:</h3>
    <div class="box">
        <code>UPDATE users SET password_hash = '<%= hash %>' WHERE email = 'admin@workbridge.com';</code>
    </div>
    
    <p><strong>Instructions:</strong></p>
    <ol>
        <li>Copy the SQL command above.</li>
        <li>Open <strong>MySQL Workbench</strong>.</li>
        <li>Connect to your database and paste the command into a New Query tab.</li>
        <li>Run it (click the lightning bolt).</li>
        <li>Try logging in again at <a href="auth?action=login">Login Page</a>.</li>
    </ol>
    
    <p><small>Delete this file (<code>hash.jsp</code>) after you are done for security.</small></p>
</body>
</html>
