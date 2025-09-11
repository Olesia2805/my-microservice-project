# My own microservice project
This is a repository for an educational project within the DevOps CI/CD course.

## [DevTools Setup Script](/install_dev_tools.sh)

This Bash script automates the installation and setup of a Python development environment with Docker, Docker Compose, and Django on Ubuntu-based systems. It also creates and activates a Python virtual environment.

### Features

- Installs essential packages: docker.io, docker-compose, python3, python3-venv, and python3-pip.
- Checks Python version and ensures Python 3.9 or newer is installed.
- Creates and activates a virtual environment (devtools_venv).
- Upgrades pip inside the virtual environment.
- Installs Django inside the virtual environment.
- Provides color-coded console messages for easy readability.

### Usage

Make the script executable:
```bash
chmod +x install_dev_tools.sh
```

Run the script:
```bash
./install_dev_tools.sh
```

Activate the virtual environment:
```bash
source devtools_venv/bin/activate
```

---

## [Django Project](/docker/)

This project is a Dockerized Django web application with PostgreSQL as the database and Nginx as a reverse proxy.

### Project Structure

```
docker/
├── django/
│ ├── goit/
│ ├── manage.py
│ ├── requirements.txt
│ └── Dockerfile
├── nginx/
│ └── nginx.conf
└── docker-compose.yml
```

### Setup Instructions

*Clone the repository:*
```bash
git clone https://github.com/Olesia2805/my-microservice-project.git
cd docker
```

*Create a .env file with the following variables:*
```
POSTGRES_DB=
POSTGRES_USER=
POSTGRES_PASSWORD=
POSTGRES_HOST=
POSTGRES_PORT=
```

*Build and start the containers:*
```bash
sudo docker-compose up -d --build
```

**Verify:**
- Django app: http://localhost:8000

![app_8000](docker/app_8000.png)

- Nginx proxy: http://localhost

![app_80](docker/app_80.png)

**Notes:**

- To stop the containers:
```bash
sudo docker-compose down
```
- To remove unused containers, volumes, and networks:
```bash
sudo docker system prune -f
```

## [Terraform HW5](/terraform-hw-5/)

Структура проєкту
```
terraform-hw-5/
│
├── main.tf                  # Головний файл для підключення модулів
├── backend.tf               # Налаштування бекенду для стейтів (S3 + DynamoDB)
├── outputs.tf               # Загальне виведення ресурсів
│
├── modules/                 # Каталог з усіма модулями
│   │
│   ├── s3-backend/          # Модуль для S3 та DynamoDB
│   │   ├── s3.tf            # Створення S3-бакета
│   │   ├── dynamodb.tf      # Створення DynamoDB
│   │   ├── variables.tf     # Змінні для S3
│   │   └── outputs.tf       # Виведення інформації про S3 та DynamoDB
│   │
│   ├── vpc/                 # Модуль для VPC
│   │   ├── vpc.tf           # Створення VPC, підмереж, Internet Gateway
│   │   ├── routes.tf        # Налаштування маршрутизації
│   │   ├── variables.tf     # Змінні для VPC
│   │   └── outputs.tf       # Виведення інформації про VPC
│   │
│   └── ecr/                 # Модуль для ECR
│       ├── ecr.tf           # Створення ECR репозиторію
│       ├── variables.tf     # Змінні для ECR
│       └── outputs.tf       # Виведення URL репозиторію ECR
│
└── README.md                # Документація проєкту
```

### Схема взаємодії модулів

```
                ┌───────────────┐
                │   Terraform   │
                │   main.tf     │
                └──────┬────────┘
                       │
    ┌──────────────────┼─────────────────────┐
    │                  │                     │
┌───▼───┐          ┌───▼───┐             ┌───▼───┐
│s3-    │          │ vpc   │             │ ecr   │
│backend│          │module │             │module │
└───┬───┘          └───┬───┘             └───┬───┘
    │                  │                     │
    │                  │                     │
    │                  │                     │
┌───▼───────────────┐ ┌▼──────────────────┐ ┌▼──────────────┐
│ S3 Bucket         │ │ VPC               │ │ ECR Repo      │
│ terraform.tfstate │ │ ├─ Public Subnets │ │ Images        │
│ Versioning        │ │ ├─ Private Subnets│ │ Scan on Push  │
│ Ownership         │ │ └─ Internet GW    │ │ Tags          │
│ DynamoDB          │ │ Routing Tables    │ └───────────────┘
└───────────────────┘ └───────────────────┘

```

**Пояснення:**
- `main.tf` викликає всі модулі (`s3-backend`, `vpc`, `ecr`) та координує створення інфраструктури.
- **S3-backend**
   - Створює S3-бакет для зберігання `terraform.tfstate`.
   - Включає версіонування файлів для можливості відновлення стану.
   - Налаштовує власність об’єктів (BucketOwnerEnforced) для безпечного доступу.
   - Створює DynamoDB таблицю для блокування стану (locking).
- **VPC**
   - Створює ізольовану VPC мережу.
   - Створює публічні та приватні підмережі у вказаних Availability Zones.
   - Додає Internet Gateway для виходу публічних підмереж в Інтернет.
   - Налаштовує маршрутизацію між підмережами.
- **ECR**
   - Створює ECR репозиторій для зберігання Docker образів.
   - Налаштовує сканування образів при пуші на наявність вразливостей.
   - Додає теги для середовища та назви репозиторію.

### Приклад використання Terraform

- Terraform init
![terraform init](./terraform-hw-5/img/terraform_init.png)

- Terraform plan
![terraform plan](./terraform-hw-5/img/terraform_plan.png)

- Terraform apply
![terraform apply 1](./terraform-hw-5/img/terraform_apply_1.png)
![terraform apply 2](./terraform-hw-5/img/terraform_apply_2.png)

- Terraform destroy
![terraform destroy](./terraform-hw-5/img/terraform_destroy.png)
