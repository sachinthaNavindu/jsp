
# Complaint Management System (CMS)

A full-stack web application prototype developed for the Municipal IT Division to manage internal employee complaints and administrative issue tracking. Built using **JSP, Jakarta EE, DBCP, and MySQL**, this system supports synchronous complaint submission, management, and resolution through structured form-based interactions only.

---

## 📌 Project Overview

This system enables:

- **Employees** to submit, view, edit, and delete unresolved complaints.
- **Admins** to view all complaints, update their statuses with remarks, and delete any complaint.

All backend interactions are strictly performed using **HTML `<form>` submissions** via **HTTP GET and POST**, with no use of AJAX or JavaScript-based asynchronous methods.

---

## 🛠️ Technologies Used

- **Frontend**: JSP, HTML, CSS, JavaScript (only for input validation)
- **Backend**: Jakarta EE (Servlets)
- **Database**: MySQL (with Apache Commons DBCP connection pooling)
- **Architecture**: MVC (Model-View-Controller)
- **Server**: Apache Tomcat (localhost deployment)

---

## ⚙️ Setup & Configuration Guide

### 1. Clone the Repository

```bash
git clone https://github.com/sachinthaNavindu/Employee-Complaint-System.git
cd complaint-management-system
