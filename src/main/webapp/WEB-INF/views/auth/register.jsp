<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register | WorkBridge</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css?v=2">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/auth.css">
    <script src="https://unpkg.com/@phosphor-icons/web"></script>
</head>
<body>

<div class="auth-layout">
    <div class="auth-left">
        <div class="brand">
            <a href="${pageContext.request.contextPath}/">
                <img src="${pageContext.request.contextPath}/images/logo.jpg" alt="WorkBridge" onerror="this.src='https://via.placeholder.com/200x70?text=WorkBridge'">
            </a>
        </div>
        <div class="left-content">
            <h1>Bridge Your Career<br>to <span class="text-blue">Better Opportunities</span></h1>
            <p class="subtitle">WorkBridge connects talented people with great companies. Find jobs, build your profile, and take the next step in your career.</p>
            
            <div class="feature-list">
                <div class="feature-item">
                    <div class="f-icon bg-blue-light"><i class="ph ph-briefcase text-blue"></i></div>
                    <div>
                        <h4>Find the right job</h4>
                        <p>Search thousands of active job listings from top companies.</p>
                    </div>
                </div>
                <div class="feature-item">
                    <div class="f-icon bg-green-light"><i class="ph ph-user text-green"></i></div>
                    <div>
                        <h4>Build your profile</h4>
                        <p>Create a professional profile and let employers find you.</p>
                    </div>
                </div>
                <div class="feature-item">
                    <div class="f-icon bg-purple-light"><i class="ph ph-trend-up text-purple"></i></div>
                    <div>
                        <h4>Track your progress</h4>
                        <p>Manage your applications and track your progress in one place.</p>
                    </div>
                </div>
            </div>
        </div>
        <div class="bg-illustration"></div>
    </div>
    
    <div class="auth-right">
        <div class="auth-card register-card">
            <div class="text-center mb-4">
                <h2>Create a new account</h2>
                <p class="text-muted">Join WorkBridge and take the next step in your career.</p>
            </div>
            
            <c:if test="${not empty error}">
                <div class="alert alert-error mb-3">${error}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/auth" method="post" id="registerForm">
                <%@ include file="/WEB-INF/views/common/csrf_token.jspf" %>
                <input type="hidden" name="action" value="register">
                
                <div class="form-row">
                    <div class="form-group flex-1">
                        <label>Full Name</label>
                        <div class="input-with-icon">
                            <i class="ph ph-user"></i>
                            <input type="text" name="fullName" placeholder="Enter your full name" required value="${param.fullName}">
                        </div>
                    </div>
                    <div class="form-group flex-1">
                        <label>Email Address</label>
                        <div class="input-with-icon">
                            <i class="ph ph-envelope-simple"></i>
                            <input type="email" name="email" placeholder="Enter your email address" required value="${param.email}">
                        </div>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group flex-1">
                        <label>Phone Number</label>
                        <div class="input-with-icon">
                            <i class="ph ph-phone"></i>
                            <input type="text" name="phone" placeholder="Enter your phone number" required value="${param.phone}">
                        </div>
                    </div>
                    <div class="form-group flex-1">
                        <label>Password</label>
                        <div class="input-with-icon">
                            <i class="ph ph-lock-key"></i>
                            <input type="password" id="password" name="password" placeholder="Create a password" required>
                            <button type="button" class="btn-eye" onclick="togglePassword('password')"><i class="ph ph-eye"></i></button>
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <label>Confirm Password</label>
                    <div class="input-with-icon">
                        <i class="ph ph-lock-key"></i>
                        <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Confirm your password" required>
                        <button type="button" class="btn-eye" onclick="togglePassword('confirmPassword')"><i class="ph ph-eye"></i></button>
                    </div>
                </div>

                <div class="form-group">
                    <label>I am a:</label>
                    <div class="role-selector">
                        <label class="role-card ${param.role != 'EMPLOYER' ? 'active' : ''}">
                            <input type="radio" name="role" value="JOB_SEEKER" ${param.role != 'EMPLOYER' ? 'checked' : ''} onchange="updateRoleUI()">
                            <div class="r-icon bg-blue-light"><i class="ph ph-users text-blue"></i></div>
                            <div>
                                <strong>Job Seeker</strong>
                                <span class="text-muted text-sm block">I am looking for a job</span>
                            </div>
                        </label>
                        <label class="role-card ${param.role == 'EMPLOYER' ? 'active' : ''}">
                            <input type="radio" name="role" value="EMPLOYER" ${param.role == 'EMPLOYER' ? 'checked' : ''} onchange="updateRoleUI()">
                            <div class="r-icon bg-green-light"><i class="ph ph-briefcase text-green"></i></div>
                            <div>
                                <strong>Employer</strong>
                                <span class="text-muted text-sm block">I want to hire talent</span>
                            </div>
                        </label>
                    </div>
                </div>

                <div class="form-group remember-me">
                    <label class="flex align-center gap-2">
                        <input type="checkbox" required>
                        <span>I agree to the <a href="#" class="text-blue">Terms of Service</a> and <a href="#" class="text-blue">Privacy Policy</a></span>
                    </label>
                </div>

                <button type="submit" class="btn btn-primary w-100 mb-3">Create Account</button>
            </form>
            

            
            <p class="text-center">
                Already have an account? <a href="${pageContext.request.contextPath}/auth?action=login" class="text-blue font-bold">Log in</a>
            </p>
        </div>
    </div>
</div>

<footer class="auth-footer">
    <div class="footer-features">
        <div class="f-feat"><i class="ph ph-shield-check"></i> <div><strong>Secure & Trusted</strong><br><span class="text-muted">Your data is safe with us.</span></div></div>
        <div class="f-feat"><i class="ph ph-users"></i> <div><strong>For Everyone</strong><br><span class="text-muted">Job Seekers, Employers, and Administrators.</span></div></div>
        <div class="f-feat"><i class="ph ph-headset"></i> <div><strong>Need Help?</strong><br><span class="text-muted">Contact our support team anytime.</span></div></div>
    </div>
    <div class="footer-links">
        <div class="copyright">© 2025 WorkBridge. All rights reserved.</div>
        <div class="links">
            <a href="#">About Us</a> | <a href="#">Privacy Policy</a> | <a href="#">Terms of Service</a> | <a href="#">Contact</a>
        </div>
        <div class="socials">
            <i class="ph-fill ph-linkedin-logo"></i>
            <i class="ph-fill ph-facebook-logo"></i>
            <i class="ph-fill ph-twitter-logo"></i>
            <i class="ph-fill ph-envelope-simple"></i>
        </div>
    </div>
</footer>

<script>
    function togglePassword(id) {
        const input = document.getElementById(id);
        input.type = input.type === 'password' ? 'text' : 'password';
    }
    
    function updateRoleUI() {
        document.querySelectorAll('.role-card').forEach(card => card.classList.remove('active'));
        const checked = document.querySelector('input[name="role"]:checked');
        if(checked) {
            checked.closest('.role-card').classList.add('active');
        }
    }
</script>
</body>
</html>
