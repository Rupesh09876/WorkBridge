CREATE DATABASE IF NOT EXISTS workbridge_db;
USE workbridge_db;

CREATE TABLE IF NOT EXISTS users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  full_name VARCHAR(100) NOT NULL,
  email VARCHAR(150) UNIQUE NOT NULL,
  phone VARCHAR(15) UNIQUE NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  role ENUM('ADMIN','EMPLOYER','JOB_SEEKER') NOT NULL,
  status ENUM('PENDING','ACTIVE','SUSPENDED') DEFAULT 'PENDING',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_email (email),
  INDEX idx_phone (phone),
  INDEX idx_role (role),
  INDEX idx_status (status)
);

CREATE TABLE IF NOT EXISTS job_categories (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) UNIQUE NOT NULL,
  description TEXT,
  INDEX idx_name (name)
);

CREATE TABLE IF NOT EXISTS employer_profiles (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT UNIQUE,
  company_name VARCHAR(200) NOT NULL,
  company_description TEXT,
  industry VARCHAR(100),
  website_url VARCHAR(255),
  logo_url VARCHAR(255),
  location VARCHAR(150),
  founded_year INT,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS jobseeker_profiles (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT UNIQUE,
  headline VARCHAR(200),
  summary TEXT,
  skills TEXT,
  education TEXT,
  experience TEXT,
  resume_url VARCHAR(255),
  location VARCHAR(150),
  phone VARCHAR(15),
  linkedin_url VARCHAR(255),
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS job_listings (
  id INT AUTO_INCREMENT PRIMARY KEY,
  employer_id INT,
  category_id INT,
  title VARCHAR(200) NOT NULL,
  description TEXT NOT NULL,
  requirements TEXT,
  location VARCHAR(150),
  salary_range VARCHAR(100),
  job_type ENUM('FULL_TIME','PART_TIME','CONTRACT','INTERNSHIP','REMOTE'),
  status ENUM('OPEN','CLOSED','DRAFT') DEFAULT 'OPEN',
  deadline DATE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (employer_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (category_id) REFERENCES job_categories(id) ON DELETE SET NULL,
  INDEX idx_employer (employer_id),
  INDEX idx_status (status),
  INDEX idx_category (category_id),
  FULLTEXT INDEX ft_search (title, description, location)
);

CREATE TABLE IF NOT EXISTS applications (
  id INT AUTO_INCREMENT PRIMARY KEY,
  job_id INT,
  applicant_id INT,
  cover_letter TEXT,
  resume_url VARCHAR(255),
  status ENUM('PENDING','REVIEWED','SHORTLISTED','REJECTED','ACCEPTED') DEFAULT 'PENDING',
  applied_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (job_id) REFERENCES job_listings(id) ON DELETE CASCADE,
  FOREIGN KEY (applicant_id) REFERENCES users(id) ON DELETE CASCADE,
  UNIQUE KEY uq_application (job_id, applicant_id),
  INDEX idx_job (job_id),
  INDEX idx_applicant (applicant_id)
);

CREATE TABLE IF NOT EXISTS saved_jobs (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT,
  job_id INT,
  saved_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (job_id) REFERENCES job_listings(id) ON DELETE CASCADE,
  UNIQUE KEY uq_saved (user_id, job_id)
);

CREATE TABLE IF NOT EXISTS notifications (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  message TEXT NOT NULL,
  is_read BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  INDEX idx_user (user_id),
  INDEX idx_unread (user_id, is_read)
);

INSERT INTO users (full_name, email, phone, password_hash, role, status)
VALUES (
  'System Administrator',
  'admin@workbridge.com',
  '0000000000',
  '$2a$12$Z0uA5gE8vO00R1eFm2i0EOMoY8vT4Kk2I4e20XQ9E3qH9I7O7I2Qe',
  'ADMIN',
  'ACTIVE'
) ON DUPLICATE KEY UPDATE id=id;
-- Note: the password hash is an example BCrypt hash of Admin@123 using rounds=12

INSERT INTO job_categories (name, description) VALUES
  ('Information Technology', 'Software, hardware, networking and IT roles'),
  ('Healthcare', 'Medical, nursing, pharmacy and health services'),
  ('Finance & Accounting', 'Banking, auditing, and financial services'),
  ('Engineering', 'Civil, mechanical, electrical and other engineering'),
  ('Education & Training', 'Teaching, tutoring, and academic roles'),
  ('Marketing & Sales', 'Digital marketing, sales, and brand management'),
  ('Human Resources', 'Recruitment, training, and HR management')
ON DUPLICATE KEY UPDATE id=id;
