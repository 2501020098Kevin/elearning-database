create database elearning_db;
Query OK, 1 row affected (0.002 sec)

MariaDB [(none)]> use elearning_db;
Database changed
MariaDB [elearning_db]> CREATE TABLE users (
    -> user_id INT PRIMARY KEY AUTO_INCREMENT,
    -> username VARCHAR(50) NOT NULL UNIQUE,
    -> password VARCHAR(50) NOT NULL,
    -> nama_lengkap VARCHAR(100) NOT NULL,
    -> role ENUM('mahasiswa', 'dosen') NOT NULL,
    -> created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    -> );
Query OK, 0 rows affected (0.041 sec)

MariaDB [elearning_db]> CREATE TABLE courses (
    ->     course_id INT PRIMARY KEY AUTO_INCREMENT,
    ->     course_name VARCHAR(100) NOT NULL,
    ->     teacher_id INT,
    ->     FOREIGN KEY (teacher_id) REFERENCES users(user_id) ON DELETE SET NULL
    -> );
Query OK, 0 rows affected (0.050 sec)

MariaDB [elearning_db]> CREATE TABLE enrollments (
    ->     enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    ->     student_id INT NOT NULL,
    ->     course_id INT NOT NULL,
    ->     enrollment_date DATE DEFAULT (CURRENT_DATE),
    ->     FOREIGN KEY (student_id) REFERENCES users(user_id) ON DELETE CASCADE,
    ->     FOREIGN KEY (course_id) REFERENCES courses(course_id) ON DELETE CASCADE,
    ->     UNIQUE (student_id, course_id)
    -> );
Query OK, 0 rows affected (0.055 sec)

MariaDB [elearning_db]> CREATE TABLE assignments (
    ->     assignment_id INT PRIMARY KEY AUTO_INCREMENT,
    ->     course_id INT NOT NULL,
    ->     title VARCHAR(100) NOT NULL,
    ->     description TEXT,
    ->     deadline DATETIME NOT NULL,
    ->     FOREIGN KEY (course_id) REFERENCES courses(course_id) ON DELETE CASCADE
    -> );
Query OK, 0 rows affected (0.041 sec)

MariaDB [elearning_db]> CREATE TABLE grades (
    ->     grade_id INT PRIMARY KEY AUTO_INCREMENT,
    ->     assignment_id INT NOT NULL,
    ->     student_id INT NOT NULL,
    ->     score DECIMAL(5,2) NOT NULL DEFAULT 0.00,
    ->     feedback TEXT,
    ->     graded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    ->     FOREIGN KEY (assignment_id) REFERENCES assignments(assignment_id) ON DELETE CASCADE,
    ->     FOREIGN KEY (student_id) REFERENCES users(user_id) ON DELETE CASCADE,
    ->     UNIQUE (assignment_id, student_id)
    -> );
Query OK, 0 rows affected (0.033 sec)

MariaDB [elearning_db]> show tables;
+------------------------+
| Tables_in_elearning_db |
+------------------------+
| assignments            |
| courses                |
| enrollments            |
| grades                 |
| users                  |
+------------------------+
5 rows in set (0.001 sec)