<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Top Companies | WorkBridge</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css?v=2">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/landing.css">
    <script src="https://unpkg.com/@phosphor-icons/web"></script>
    <style>
        .companies-hero {
            padding: 8rem 1rem 4rem;
            background: linear-gradient(135deg, #f8fafc 0%, #eff6ff 100%);
            text-align: center;
        }
        .company-list-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 2rem;
            padding: 5rem 1rem;
        }
        .co-card {
            background: #fff;
            border: 1px solid #e2e8f0;
            border-radius: 16px;
            padding: 2rem;
            text-align: center;
            transition: all 0.3s ease;
        }
        .co-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.05);
            border-color: #2563eb;
        }
        .co-logo {
            width: 80px;
            height: 80px;
            margin: 0 auto 1.5rem;
            display: flex;
            align-items: center;
            justify-content: center;
            background: #f8fafc;
            border-radius: 12px;
        }
        .co-name {
            font-size: 1.25rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }
        .co-meta {
            color: #64748b;
            font-size: 0.9rem;
            margin-bottom: 1.5rem;
        }
        .co-stats {
            display: flex;
            justify-content: center;
            gap: 1.5rem;
            margin-bottom: 1.5rem;
            padding-top: 1rem;
            border-top: 1px solid #f1f5f9;
        }
        .co-stat-item strong {
            display: block;
            color: #0f172a;
        }
        .co-stat-item span {
            font-size: 0.8rem;
            color: #64748b;
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
            <a href="${pageContext.request.contextPath}/companies" class="active">Companies</a>
            <a href="${pageContext.request.contextPath}/resources">Resources <i class="ph ph-caret-down"></i></a>
            <a href="${pageContext.request.contextPath}/about">About Us</a>
        </div>
        <div class="nav-actions">
            <a href="${pageContext.request.contextPath}/auth?action=login" class="btn btn-outline">Login</a>
            <a href="${pageContext.request.contextPath}/auth?action=register" class="btn btn-primary">Register</a>
        </div>
    </div>
</nav>

<section class="companies-hero">
    <div class="container">
        <h1 class="hero-title">Top Companies Hiring on <span class="text-blue">WorkBridge</span></h1>
        <p class="hero-desc" style="margin: 0 auto;">Partnering with the world's leading brands to bring you the best career opportunities.</p>
    </div>
</section>

<section class="container">
    <div class="company-list-grid">
        <!-- Company 1 -->
        <div class="co-card">
            <div class="co-logo"><img src="https://img.icons8.com/color/144/google-logo.png" width="60" style="object-fit: contain;"></div>
            <div class="co-name">Google</div>
            <div class="co-meta">Technology • Mountain View, CA</div>
            <div class="co-stats">
                <div class="co-stat-item"><strong>150+</strong><span>Jobs</span></div>
                <div class="co-stat-item"><strong>4.8</strong><span>Rating</span></div>
            </div>
            <a href="${pageContext.request.contextPath}/jobs?keyword=Google" class="btn btn-outline w-100">View Openings</a>
        </div>
        <!-- Company 2 -->
        <div class="co-card">
            <div class="co-logo"><img src="https://img.icons8.com/color/144/amazon.png" width="60" style="object-fit: contain;"></div>
            <div class="co-name">Amazon</div>
            <div class="co-meta">E-commerce • Seattle, WA</div>
            <div class="co-stats">
                <div class="co-stat-item"><strong>300+</strong><span>Jobs</span></div>
                <div class="co-stat-item"><strong>4.2</strong><span>Rating</span></div>
            </div>
            <a href="${pageContext.request.contextPath}/jobs?keyword=Amazon" class="btn btn-outline w-100">View Openings</a>
        </div>
        <!-- Company 3 -->
        <div class="co-card">
            <div class="co-logo"><img src="https://img.icons8.com/color/144/microsoft.png" width="60" style="object-fit: contain;"></div>
            <div class="co-name">Microsoft</div>
            <div class="co-meta">Software • Redmond, WA</div>
            <div class="co-stats">
                <div class="co-stat-item"><strong>120+</strong><span>Jobs</span></div>
                <div class="co-stat-item"><strong>4.6</strong><span>Rating</span></div>
            </div>
            <a href="${pageContext.request.contextPath}/jobs?keyword=Microsoft" class="btn btn-outline w-100">View Openings</a>
        </div>
        <!-- Company 4 -->
        <div class="co-card">
            <div class="co-logo"><img src="https://img.icons8.com/color/144/netflix.png" width="60" style="object-fit: contain;"></div>
            <div class="co-name">Netflix</div>
            <div class="co-meta">Entertainment • Los Gatos, CA</div>
            <div class="co-stats">
                <div class="co-stat-item"><strong>45+</strong><span>Jobs</span></div>
                <div class="co-stat-item"><strong>4.9</strong><span>Rating</span></div>
            </div>
            <a href="${pageContext.request.contextPath}/jobs?keyword=Netflix" class="btn btn-outline w-100">View Openings</a>
        </div>
        <!-- Company 5 -->
        <div class="co-card">
            <div class="co-logo"><img src="https://img.icons8.com/color/144/apple-logo.png" width="45" style="object-fit: contain;"></div>
            <div class="co-name">Apple</div>
            <div class="co-meta">Consumer Electronics • Cupertino, CA</div>
            <div class="co-stats">
                <div class="co-stat-item"><strong>80+</strong><span>Jobs</span></div>
                <div class="co-stat-item"><strong>4.7</strong><span>Rating</span></div>
            </div>
            <a href="${pageContext.request.contextPath}/jobs?keyword=Apple" class="btn btn-outline w-100">View Openings</a>
        </div>
        <!-- Company 6 -->
        <div class="co-card">
            <div class="co-logo"><img src="https://img.icons8.com/color/144/meta.png" width="60" style="object-fit: contain;"></div>
            <div class="co-name">Meta</div>
            <div class="co-meta">Social Media • Menlo Park, CA</div>
            <div class="co-stats">
                <div class="co-stat-item"><strong>60+</strong><span>Jobs</span></div>
                <div class="co-stat-item"><strong>4.1</strong><span>Rating</span></div>
            </div>
            <a href="${pageContext.request.contextPath}/jobs?keyword=Meta" class="btn btn-outline w-100">View Openings</a>
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
