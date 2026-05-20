<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>WorkBridge — Connecting Talent with Opportunity</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css?v=2">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/landing.css">
    <!-- Phosphor Icons for modern icons -->
    <script src="https://unpkg.com/@phosphor-icons/web"></script>
</head>
<body>

<!-- Navigation -->
<nav class="navbar">
    <div class="container nav-container">
        <a href="${pageContext.request.contextPath}/" class="nav-brand">
            <img src="${pageContext.request.contextPath}/images/logo.jpg" alt="WorkBridge" class="logo" onerror="this.src='https://via.placeholder.com/200x70?text=WorkBridge'">
        </a>
        <input type="checkbox" id="nav-toggle" class="nav-toggle">
        <label for="nav-toggle" class="nav-toggle-label">
            <span></span>
        </label>
        <div class="nav-links nav-menu">
            <a href="${pageContext.request.contextPath}/" class="active">Home</a>
            <a href="${pageContext.request.contextPath}/jobs">Jobs</a>
            <a href="${pageContext.request.contextPath}/companies">Companies</a>
            <a href="${pageContext.request.contextPath}/resources">Resources <i class="ph ph-caret-down"></i></a>
            <a href="${pageContext.request.contextPath}/about">About Us</a>
            <div class="nav-actions-mobile">
                <a href="${pageContext.request.contextPath}/auth?action=login" class="btn btn-outline">Login</a>
                <a href="${pageContext.request.contextPath}/auth?action=register" class="btn btn-primary">Register</a>
            </div>
        </div>
        <div class="nav-actions">
            <a href="${pageContext.request.contextPath}/auth?action=login" class="btn btn-outline">Login</a>
            <a href="${pageContext.request.contextPath}/auth?action=register" class="btn btn-primary">Register</a>
        </div>
    </div>
</nav>

<!-- Hero Section -->
<section class="hero container">
    <div class="hero-content">
        <h1 class="hero-title">Find the right job.<br><span class="text-blue">Build your future.</span></h1>
        <p class="hero-desc">WorkBridge connects talented people with great companies. Discover opportunities, grow your skills, and advance your career.</p>
        <div class="hero-btns">
            <a href="${pageContext.request.contextPath}/jobs" class="btn btn-primary btn-lg">Find Jobs</a>
            <a href="${pageContext.request.contextPath}/auth?action=register&role=EMPLOYER" class="btn btn-outline btn-lg">Post a Job</a>
        </div>
        <div class="hero-stats">
            <div class="hero-stat">
                <div class="stat-icon"><i class="ph ph-briefcase"></i></div>
                <div><strong>10K+</strong><br><span>Active Jobs</span></div>
            </div>
            <div class="hero-stat">
                <div class="stat-icon"><i class="ph ph-buildings"></i></div>
                <div><strong>5K+</strong><br><span>Companies</span></div>
            </div>
            <div class="hero-stat">
                <div class="stat-icon"><i class="ph ph-users"></i></div>
                <div><strong>25K+</strong><br><span>Job Seekers</span></div>
            </div>
        </div>
    </div>
    <div class="hero-image">
        <!-- Using a placeholder for the hero image -->
        <img src="https://images.unsplash.com/photo-1600880292203-757bb62b4baf?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80" alt="People working" class="main-img" style="border-radius: 20px;">
    </div>
</section>

<!-- Search Bar -->
<section class="search-section container">
    <div class="search-box">
        <div class="search-input-group">
            <i class="ph ph-magnifying-glass"></i>
            <input type="text" placeholder="Job title, keywords, or company">
        </div>
        <div class="divider"></div>
        <div class="search-input-group">
            <i class="ph ph-list"></i>
            <select>
                <option>All Categories</option>
            </select>
        </div>
        <div class="divider"></div>
        <div class="search-input-group">
            <i class="ph ph-map-pin"></i>
            <input type="text" placeholder="Location">
        </div>
        <button class="btn btn-primary search-btn"><i class="ph ph-magnifying-glass"></i> Search Jobs</button>
    </div>
    <div class="popular-searches">
        <strong>Popular Searches:</strong>
        <span class="tag">Web Developer</span>
        <span class="tag">Designer</span>
        <span class="tag">Marketing</span>
        <span class="tag">Data Analyst</span>
        <span class="tag">Project Manager</span>
    </div>
</section>

<!-- Categories -->
<section class="categories-section container">
    <div class="section-header text-center">
        <h2>Browse by Category</h2>
        <p>Explore job opportunities in your field of interest.</p>
    </div>
    <div class="category-grid">
        <div class="cat-card"><i class="ph ph-code" style="color: #2563eb;"></i><span>Development</span></div>
        <div class="cat-card"><i class="ph ph-pen-nib" style="color: #f59e0b;"></i><span>Design</span></div>
        <div class="cat-card"><i class="ph ph-megaphone" style="color: #10b981;"></i><span>Marketing</span></div>
        <div class="cat-card"><i class="ph ph-briefcase" style="color: #f97316;"></i><span>Business</span></div>
        <div class="cat-card"><i class="ph ph-chart-line-up" style="color: #8b5cf6;"></i><span>Finance</span></div>
        <div class="cat-card"><i class="ph ph-users" style="color: #3b82f6;"></i><span>HR & Admin</span></div>
        <div class="cat-card"><i class="ph ph-wrench" style="color: #ef4444;"></i><span>Engineering</span></div>
        <div class="cat-card"><i class="ph ph-squares-four" style="color: #64748b;"></i><span>More Categories</span></div>
    </div>
</section>

<!-- Why Choose Us -->
<section class="why-us-section container">
    <div class="why-us-img">
        <img src="https://images.unsplash.com/photo-1573164713988-8665fc963095?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80" alt="Why us" style="border-radius: 20px; width: 100%;">
    </div>
    <div class="why-us-content">
        <h2>Why Choose WorkBridge?</h2>
        <p>We make job hunting simple, transparent, and effective.</p>
        <div class="feature-list">
            <div class="feature-item">
                <div class="f-icon"><i class="ph ph-magnifying-glass"></i></div>
                <div>
                    <h4>Easy & Fast Search</h4>
                    <p>Find jobs that match your skills in just a few clicks.</p>
                </div>
            </div>
            <div class="feature-item">
                <div class="f-icon"><i class="ph ph-check-circle"></i></div>
                <div>
                    <h4>Verified Companies</h4>
                    <p>All companies are verified for a trustworthy experience.</p>
                </div>
            </div>
            <div class="feature-item">
                <div class="f-icon"><i class="ph ph-chart-line"></i></div>
                <div>
                    <h4>Track Applications</h4>
                    <p>Track your application status in real-time.</p>
                </div>
            </div>
            <div class="feature-item">
                <div class="f-icon"><i class="ph ph-file-text"></i></div>
                <div>
                    <h4>Career Resources</h4>
                    <p>Get tips, guides, and resources to grow your career.</p>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Featured Jobs -->
<section class="featured-jobs container">
    <div class="section-header flex justify-between align-center">
        <div>
            <h2>Featured Jobs</h2>
            <p>Check out some of the latest opportunities.</p>
        </div>
        <a href="#" class="view-all">View all <i class="ph ph-arrow-right"></i></a>
    </div>
    <div class="jobs-grid">
        <div class="job-card">
            <div class="j-head">
                <div class="j-logo" style="background: #fff; padding: 5px; border-radius: 8px; box-shadow: 0 2px 5px rgba(0,0,0,0.1);"><img src="${pageContext.request.contextPath}/images/software_engineer.png" width="40" style="object-fit: contain;"></div>
                <i class="ph ph-bookmark"></i>
            </div>
            <h4>Software Engineer</h4>
            <div class="j-company">Google</div>
            <div class="j-location"><i class="ph ph-map-pin"></i> Kathmandu, Nepal</div>
            <div class="j-tags">
                <span class="j-tag blue">Full-time</span>
                <span class="j-tag gray">On-site</span>
            </div>
            <div class="j-posted">Posted 2h ago</div>
        </div>
        <div class="job-card">
            <div class="j-head">
                <div class="j-logo" style="background: #fff; padding: 5px; border-radius: 8px; box-shadow: 0 2px 5px rgba(0,0,0,0.1);"><img src="${pageContext.request.contextPath}/images/uiux_designer.png" width="40" style="object-fit: contain;"></div>
                <i class="ph ph-bookmark"></i>
            </div>
            <h4>UI/UX Designer</h4>
            <div class="j-company">Figma</div>
            <div class="j-location"><i class="ph ph-map-pin"></i> Remote</div>
            <div class="j-tags">
                <span class="j-tag blue">Full-time</span>
                <span class="j-tag gray">Remote</span>
            </div>
            <div class="j-posted">Posted 5h ago</div>
        </div>
        <div class="job-card">
            <div class="j-head">
                <div class="j-logo" style="background: #fff; padding: 5px; border-radius: 8px; box-shadow: 0 2px 5px rgba(0,0,0,0.1);"><img src="${pageContext.request.contextPath}/images/marketing_specialist.png" width="40" style="object-fit: contain;"></div>
                <i class="ph ph-bookmark"></i>
            </div>
            <h4>Marketing Specialist</h4>
            <div class="j-company">Unilever</div>
            <div class="j-location"><i class="ph ph-map-pin"></i> Lalitpur, Nepal</div>
            <div class="j-tags">
                <span class="j-tag blue">Full-time</span>
                <span class="j-tag gray">Hybrid</span>
            </div>
            <div class="j-posted">Posted 1d ago</div>
        </div>
        <div class="job-card">
            <div class="j-head">
                <div class="j-logo" style="background: #fff; padding: 5px; border-radius: 8px; box-shadow: 0 2px 5px rgba(0,0,0,0.1);"><img src="${pageContext.request.contextPath}/images/data_analyst.png" width="40" style="object-fit: contain;"></div>
                <i class="ph ph-bookmark"></i>
            </div>
            <h4>Data Analyst</h4>
            <div class="j-company">Daraz</div>
            <div class="j-location"><i class="ph ph-map-pin"></i> Kathmandu, Nepal</div>
            <div class="j-tags">
                <span class="j-tag blue">Full-time</span>
                <span class="j-tag gray">On-site</span>
            </div>
            <div class="j-posted">Posted 2d ago</div>
        </div>
    </div>
</section>

<!-- Stats Banner -->
<div class="stats-banner">
    <div class="container flex justify-between align-center">
        <div class="s-item"><i class="ph ph-briefcase"></i> <div><h3>10,000+</h3><p>Active Jobs</p></div></div>
        <div class="s-item"><i class="ph ph-buildings"></i> <div><h3>5,000+</h3><p>Companies</p></div></div>
        <div class="s-item"><i class="ph ph-users"></i> <div><h3>25,000+</h3><p>Job Seekers</p></div></div>
        <div class="s-item"><i class="ph ph-check-circle"></i> <div><h3>98%</h3><p>Success Rate</p></div></div>
    </div>
</div>

<!-- Testimonials -->
<section class="testimonials container">
    <div class="section-header text-center">
        <h2>What Our Users Say</h2>
        <p>Real stories from job seekers and employers.</p>
    </div>
    <div class="t-grid">
        <div class="t-card">
            <i class="ph-fill ph-quotes" style="color: #3b82f6; font-size: 2rem;"></i>
            <p>"WorkBridge helped me find my dream job in just two weeks. The platform is easy to use and very effective."</p>
            <div class="t-author"><strong>Sandesh Sharma</strong><br>Software Engineer</div>
        </div>
        <div class="t-card">
            <i class="ph-fill ph-quotes" style="color: #3b82f6; font-size: 2rem;"></i>
            <p>"As an employer, posting jobs and managing applications is so simple and streamlined."</p>
            <div class="t-author"><strong>Priya Malla</strong><br>HR Manager, Tech Solutions</div>
        </div>
        <div class="t-card">
            <i class="ph-fill ph-quotes" style="color: #3b82f6; font-size: 2rem;"></i>
            <p>"The application tracking feature keeps me updated at every step. Highly recommended!"</p>
            <div class="t-author"><strong>Anjali Karki</strong><br>Marketing Specialist</div>
        </div>
    </div>
</section>

<!-- CTA -->
<section class="cta-section container">
    <div class="cta-box">
        <div class="cta-icon"><i class="ph ph-briefcase"></i></div>
        <div class="cta-text">
            <h2>Ready to take the next step in your career?</h2>
            <p>Create your profile and start applying to jobs today.</p>
        </div>
        <div class="cta-btns">
            <a href="${pageContext.request.contextPath}/auth?action=register" class="btn btn-primary">Create Account</a>
            <a href="#" class="btn btn-outline">Learn More</a>
        </div>
    </div>
</section>

<!-- FAQ Section -->
<section class="faq-section container">
    <div class="section-header text-center">
        <h2>Frequently Asked Questions</h2>
    </div>
    <div class="faq-list">
        <div class="faq-item" onclick="toggleFaq(this)">
            <div class="faq-q">How do I apply for a job on WorkBridge? <i class="ph ph-caret-down"></i></div>
            <div class="faq-a">Create an account, build your profile, search for jobs, and click the Apply button on any listing you're interested in.</div>
        </div>
        <div class="faq-item" onclick="toggleFaq(this)">
            <div class="faq-q">Is WorkBridge free to use? <i class="ph ph-caret-down"></i></div>
            <div class="faq-a">Yes, WorkBridge is completely free for job seekers. Employers can post jobs and manage applications at no cost.</div>
        </div>
        <div class="faq-item" onclick="toggleFaq(this)">
            <div class="faq-q">Can employers search for candidates? <i class="ph ph-caret-down"></i></div>
            <div class="faq-a">Yes, employers can browse candidate profiles and reach out to potential hires directly through the platform.</div>
        </div>
        <div class="faq-item" onclick="toggleFaq(this)">
            <div class="faq-q">How can I track my application status? <i class="ph ph-caret-down"></i></div>
            <div class="faq-a">Once logged in, go to your Dashboard and click "My Applications" to see the real-time status of all your submissions.</div>
        </div>
        <div class="faq-item" onclick="toggleFaq(this)">
            <div class="faq-q">How do I contact WorkBridge support? <i class="ph ph-caret-down"></i></div>
            <div class="faq-a">You can reach our support team via the Contact page or email us at support@workbridge.com.</div>
        </div>
    </div>
</section>

<script>
function toggleFaq(el) {
    el.classList.toggle('open');
}
</script>

<!-- Footer -->
<footer class="site-footer">
    <div class="container f-grid">
        <div class="f-brand">
            <img src="${pageContext.request.contextPath}/images/logo.jpg" alt="WorkBridge" width="150" onerror="this.src='https://via.placeholder.com/150x40?text=WorkBridge'">
            <p>WorkBridge is your trusted partner in finding the right job or the right talent. Let's build a better future together.</p>
            <div class="social-icons">
                <i class="ph-fill ph-facebook-logo"></i>
                <i class="ph-fill ph-twitter-logo"></i>
                <i class="ph-fill ph-linkedin-logo"></i>
                <i class="ph-fill ph-instagram-logo"></i>
            </div>
        </div>
        <div class="f-links">
            <h4>For Job Seekers</h4>
            <ul>
                <li><a href="#">Browse Jobs</a></li>
                <li><a href="#">Create Profile</a></li>
                <li><a href="#">Career Advice</a></li>
                <li><a href="#">Help Center</a></li>
            </ul>
        </div>
        <div class="f-links">
            <h4>For Employers</h4>
            <ul>
                <li><a href="#">Post a Job</a></li>
                <li><a href="#">Search Candidates</a></li>
                <li><a href="#">Pricing</a></li>
                <li><a href="#">Employer Resources</a></li>
            </ul>
        </div>
        <div class="f-links">
            <h4>Company</h4>
            <ul>
                <li><a href="#">About Us</a></li>
                <li><a href="#">Contact Us</a></li>
                <li><a href="#">Blog</a></li>
                <li><a href="#">Careers</a></li>
            </ul>
        </div>
        <div class="f-links">
            <h4>Legal</h4>
            <ul>
                <li><a href="#">Privacy Policy</a></li>
                <li><a href="#">Terms of Service</a></li>
                <li><a href="#">Cookie Policy</a></li>
            </ul>
        </div>
    </div>
    <div class="f-bottom text-center">
        <p>© 2025 WorkBridge. All rights reserved.</p>
    </div>
</footer>

</body>
</html>
