<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Career Resources | WorkBridge</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css?v=2">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/landing.css">
    <script src="https://unpkg.com/@phosphor-icons/web"></script>
    <style>
        .resources-hero {
            padding: 8rem 1rem 4rem;
            background: #0f172a;
            color: white;
            text-align: center;
        }
        .resources-hero h1 { color: white; }
        .resources-hero .hero-desc { color: #94a3b8; }
        
        .resource-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(340px, 1fr));
            gap: 2.5rem;
            padding: 5rem 1rem;
        }
        .res-card {
            background: #fff;
            border: 1px solid #e2e8f0;
            border-radius: 16px;
            overflow: hidden;
            transition: all 0.3s ease;
        }
        .res-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.1);
        }
        .res-img {
            height: 200px;
            background-size: cover;
            background-position: center;
        }
        .res-body {
            padding: 1.5rem;
        }
        .res-tag {
            display: inline-block;
            padding: 0.25rem 0.75rem;
            background: #eff6ff;
            color: #2563eb;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
            margin-bottom: 1rem;
        }
        .res-title {
            font-size: 1.25rem;
            font-weight: 700;
            margin-bottom: 0.75rem;
            line-height: 1.4;
        }
        .res-excerpt {
            color: #64748b;
            font-size: 0.95rem;
            margin-bottom: 1.5rem;
        }
        .res-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            color: #94a3b8;
            font-size: 0.85rem;
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
            <a href="${pageContext.request.contextPath}/resources" class="active">Resources <i class="ph ph-caret-down"></i></a>
            <a href="${pageContext.request.contextPath}/about">About Us</a>
        </div>
        <div class="nav-actions">
            <a href="${pageContext.request.contextPath}/auth?action=login" class="btn btn-outline">Login</a>
            <a href="${pageContext.request.contextPath}/auth?action=register" class="btn btn-primary">Register</a>
        </div>
    </div>
</nav>

<section class="resources-hero">
    <div class="container">
        <h1 class="hero-title">Career <span class="text-blue">Resources</span></h1>
        <p class="hero-desc" style="margin: 0 auto;">Expert advice to help you land your dream job and grow your career.</p>
    </div>
</section>

<section class="container">
    <div class="resource-grid">
        <!-- Resource 1 -->
        <div class="res-card">
            <div class="res-img" style="background-image: url('https://images.unsplash.com/photo-1586281380349-632531db7ed4?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80')"></div>
            <div class="res-body">
                <span class="res-tag">Resume Tips</span>
                <h3 class="res-title">How to Write a Resume That Gets Noticed in 2025</h3>
                <p class="res-excerpt">Discover the latest trends in resume writing and how to beat the Applicant Tracking Systems (ATS).</p>
                <div class="res-footer">
                    <span>5 min read</span>
                    <span>May 10, 2025</span>
                </div>
            </div>
        </div>
        <!-- Resource 2 -->
        <div class="res-card">
            <div class="res-img" style="background-image: url('https://images.unsplash.com/photo-1521791136064-7986c2959210?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80')"></div>
            <div class="res-body">
                <span class="res-tag">Interview Prep</span>
                <h3 class="res-title">Mastering the Behavioral Interview: The STAR Method</h3>
                <p class="res-excerpt">Learn how to answer tough interview questions with specific examples that prove your skills.</p>
                <div class="res-footer">
                    <span>8 min read</span>
                    <span>May 8, 2025</span>
                </div>
            </div>
        </div>
        <!-- Resource 3 -->
        <div class="res-card">
            <div class="res-img" style="background-image: url('https://images.unsplash.com/photo-1552664730-d307ca884978?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80')"></div>
            <div class="res-body">
                <span class="res-tag">Career Growth</span>
                <h3 class="res-title">Networking Strategies for Introverts</h3>
                <p class="res-excerpt">Build meaningful professional connections without feeling overwhelmed by large networking events.</p>
                <div class="res-footer">
                    <span>6 min read</span>
                    <span>May 5, 2025</span>
                </div>
            </div>
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
