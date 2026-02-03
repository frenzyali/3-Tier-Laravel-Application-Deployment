# Laravel Multi‑App Docker Setup 🚀

**Dockerized Laravel setup** where multiple Laravel applications run together using a **single MySQL database service** and are exposed through an **Nginx reverse proxy**.

---

## 📦 What’s Inside

* **3 Laravel applications**

  * `realworld`
  * `crud`
  * `coffee`
* **Single MySQL service** (multiple databases)
* **Nginx reverse proxy** (path‑based routing)
* **Docker & Docker Compose** for orchestration

Each Laravel app runs in its own container but shares the same database container.

---

## 🧰 Tech Stack

* **Docker**
* **Docker Compose**
* **Laravel (PHP 8.4)**
* **MySQL 8.0**
* **Nginx** (Reverse Proxy)
* **Node.js (for frontend assets)**
* **Composer**

---

## 🗂 Project Structure

```text
laravel-project/
│
├── realworld/
│   ├── Dockerfile
│   └── entrypoint.sh
│
├── crud/
│   ├── Dockerfile
│   └── entrypoint.sh
│
├── coffee/
│   ├── Dockerfile
│   └── entrypoint.sh
│
├── nginx/
│   ├── conf.d/
│   └── sites-enabled/
│
├── mysql/
│   └── init.sql
│
├── envs/
│   ├── db.env
│   ├── crud.env
│   ├── coffee.env
│   └── realworld.env
│
└── docker-compose.yml
```

---

## 🐳 Docker Compose Overview

All services are defined in a single `docker-compose.yml` file.

Services included:

* `realworld`
* `crud`
* `coffee`
* `db` (MySQL)
* `nginx`

---

## 🐘 Laravel Containers

Each Laravel app:

* Has its **own Dockerfile**
* Uses **multi‑stage builds**
* Installs:

  * PHP dependencies via Composer
  * Node dependencies via npm
* Runs migrations automatically on startup

---

## 🛢 Database Setup

* A **single MySQL container** is used
* Multiple databases are created using `init.sql`
* Each Laravel app connects to its own database

Example:

* `coffee` → `laracoffee`
* `crud` → `crud`
* `realworld` → `realworld`

MySQL initialization happens automatically when the container starts for the first time.

---

## 🔁 Nginx Reverse Proxy

Nginx is used to route traffic to different Laravel apps using paths:

| URL Path     | App           |
| ------------ | ------------- |
| `/coffee`    | Coffee App    |
| `/crud`      | CRUD App      |
| `/realworld` | RealWorld App |

Nginx proxies requests internally to:

* `coffee:8002`
* `crud:8001`
* `realworld:8000`

## ▶️ How to Run

```bash
docker compose up --build
```

Then access:

* [http://localhost:8080/coffee](http://localhost:8080/coffee)
* [http://localhost:8080/crud](http://localhost:8080/crud)
* [http://localhost:8080/realworld](http://localhost:8080/realworld)

---


