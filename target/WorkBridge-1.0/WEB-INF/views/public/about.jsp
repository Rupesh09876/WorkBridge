<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us | WorkBridge</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css?v=2">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/landing.css">
    <script src="https://unpkg.com/@phosphor-icons/web"></script>
    <style>
        .about-hero {
            padding: 10rem 1rem 6rem;
            background: linear-gradient(rgba(15, 23, 42, 0.8), rgba(15, 23, 42, 0.8)), url('https://images.unsplash.com/photo-1522071820081-009f0129c71c?ixlib=rb-4.0.3&auto=format&fit=crop&w=1400&q=80');
            background-size: cover;
            background-position: center;
            color: white;
            text-align: center;
        }
        .about-hero h1 { color: white; margin-bottom: 1.5rem; }
        
        .mission-section {
            padding: 6rem 1rem;
            text-align: center;
        }
        .mission-box {
            max-width: 800px;
            margin: 0 auto;
        }
        .mission-box h2 {
            font-size: 2.5rem;
            margin-bottom: 2rem;
        }
        .mission-box p {
            font-size: 1.25rem;
            line-height: 1.8;
            color: #475569;
        }
        
        .values-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 3rem;
            padding: 5rem 1rem;
            background: #f8fafc;
        }
        .value-item {
            text-align: center;
            padding: 2rem;
        }
        .value-icon {
            font-size: 3rem;
            color: #2563eb;
            margin-bottom: 1.5rem;
        }
        .value-item h3 {
            font-size: 1.5rem;
            margin-bottom: 1rem;
        }
    </style>
</head>
<body>

<nav class="navbar">
    <div class="container nav-container">
        <a href="${pageContext.request.contextPath}/" class="nav-brand">
            <img src="${pageContext.request.contextPath}/images/logo.jpg" alt="WorkBridge" class="logo" onerror="this.src='https://via.placeholder.com/200x70?text=WorkBridge'">
        </a>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/">Home</a>
            <a href="${pageContext.request.contextPath}/jobs">Jobs</a>
            <a href="${pageContext.request.contextPath}/companies">Companies</a>
            <a href="${pageContext.request.contextPath}/resources">Resources <i class="ph ph-caret-down"></i></a>
            <a href="${pageContext.request.contextPath}/about" class="active">About Us</a>
        </div>
        <div class="nav-actions">
            <a href="${pageContext.request.contextPath}/auth?action=login" class="btn btn-outline">Login</a>
            <a href="${pageContext.request.contextPath}/auth?action=register" class="btn btn-primary">Register</a>
        </div>
    </div>
</nav>

<section class="about-hero">
    <div class="container">
        <h1 class="hero-title">Bridging the Gap Between <br><span class="text-blue">Talent & Opportunity</span></h1>
        <p class="hero-desc" style="margin: 0 auto; color: #cbd5e1;">Our mission is to create a more transparent and efficient job market for everyone.</p>
    </div>
</section>

<section class="mission-section">
    <div class="container mission-box">
        <h2>Our Story</h2>
        <p>Founded in 2025, WorkBridge was born out of a simple idea: that finding a job shouldn't be a job in itself. We've built a platform that puts people first, focusing on meaningful connections rather than just resume matches.</p>
    </div>
</section>

<section class="values-grid">
    <div class="container" style="display: contents;">
        <div class="value-item">
            <div class="value-icon"><i class="ph ph-heart"></i></div>
            <h3>People First</h3>
            <p>We build tools that empower job seekers and value the human behind the application.</p>
        </div>
        <div class="value-item">
            <div class="value-icon"><i class="ph ph-shield-check"></i></div>
            <h3>Trust & Safety</h3>
            <p>We verify every company on our platform to ensure a safe and trustworthy experience.</p>
        </div>
        <div class="value-item">
            <div class="value-icon"><i class="ph ph-lightning"></i></div>
            <h3>Innovation</h3>
            <p>We constantly iterate to make the recruitment process faster and more effective.</p>
        </div>
    </div>
</section>

<footer class="site-footer">
    <div class="container f-bottom text-center" style="padding: 2rem 0;">
        <p>© 2025 WorkBridge. All rights reserved.</p>
    </div>
</footer>

</body>
</html>
