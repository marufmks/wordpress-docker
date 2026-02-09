# 🐳 WordPress Docker Development Environment

[![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)](https://www.docker.com/)
[![WordPress](https://img.shields.io/badge/WordPress-21759B?style=for-the-badge&logo=wordpress&logoColor=white)](https://wordpress.org/)
[![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white)](https://www.mysql.com/)
[![PHP](https://img.shields.io/badge/PHP-777BB4?style=for-the-badge&logo=php&logoColor=white)](https://www.php.org/)

> A complete WordPress development environment with Docker, featuring WP-CLI, Xdebug, Adminer, and Mailpit for seamless local development.

---

## 🚀 Quick Start

Get your WordPress site running in under 5 minutes!

```bash
# Clone the repository
git clone <your-repo-url>
cd wordpress-docker

# Start all services
docker compose up -d

# Access your WordPress site
open http://localhost:8080
```

That's it! 🎉 Your WordPress site is now running with all development tools ready.

---

## 📋 Table of Contents

- [🏗️ Architecture](#-architecture)
- [🛠️ Services Overview](#️-services-overview)
- [⚙️ Installation](#️-installation)
- [🎯 Usage](#-usage)
- [🔧 Development Tools](#-development-tools)
- [📁 Project Structure](#-project-structure)
- [🔌 WP-CLI Commands](#-wp-cli-commands)
- [🐛 Debugging](#-debugging)
- [📝 Environment Variables](#-environment-variables)
- [🔄 Common Tasks](#-common-tasks)
- [🚨 Troubleshooting](#-troubleshooting)
- [🤝 Contributing](#-contributing)
- [📄 License](#-license)

---

## 🏗️ Architecture

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   WordPress     │    │     MySQL       │    │     WP-CLI      │
│   (Apache)      │◄──►│    (Database)   │◄──►│   (CLI Tool)    │
│   Port: 8080    │    │   Port: 3306    │    │   Persistent    │
└─────────────────┘    └─────────────────┘    └─────────────────┘
         │                       │                       │
         └───────────────────────┼───────────────────────┘
                                 │
         ┌─────────────────┐    ┌─────────────────┐
         │    Adminer      │    │     Mailpit     │
         │  (DB Admin)     │    │   (Email Test)  │
         │  Port: 8081     │    │ Ports: 1025/8025│
         └─────────────────┘    └─────────────────┘
```

---

## 🛠️ Services Overview

| Service | Image | Port | Description | Purpose |
|---------|-------|------|-------------|---------|
| **WordPress** | `wordpress:php8.2-apache` | 8080 | Main WordPress application | Web server & PHP |
| **MySQL** | `mysql:8.0` | 3306 | Database server | Data storage |
| **WP-CLI** | `wordpress:cli` | - | Command-line interface | WordPress management |
| **Adminer** | `adminer` | 8081 | Database administration | GUI database access |
| **Mailpit** | `axllent/mailpit` | 1025/8025 | Email testing | Development emails |

---

## ⚙️ Installation

### Prerequisites

- [Docker](https://www.docker.com/get-docker) (v20.10+)
- [Docker Compose](https://docs.docker.com/compose/install/) (v2.0+)
- [Git](https://git-scm.com/)

### Step-by-Step Setup

1. **Clone the Repository**
   ```bash
   git clone <your-repository-url>
   cd wordpress-docker
   ```

2. **Configure Environment (Optional)**
   ```bash
   # Copy and customize environment variables
   cp .env.example .env
   # Edit .env with your preferred settings
   ```

3. **Start Services**
   ```bash
   # Start all services in detached mode
   docker compose up -d
   
   # View service status
   docker compose ps
   ```

4. **Complete WordPress Installation**
   - Navigate to `http://localhost:8080`
   - Follow the WordPress setup wizard
   - Use these database credentials:
     - **Database Name**: `wordpress`
     - **User**: `wpuser`
     - **Password**: `wppassword`
     - **Host**: `mysql`

5. **Verify Setup**
   ```bash
   # Test WP-CLI
   ./wpcli.sh core version
   
   # Check all services
   docker compose ps
   ```

---

## 🎯 Usage

### WordPress Site
- **URL**: `http://localhost:8080`
- **Admin**: `http://localhost:8080/wp-admin`

### Database Administration
- **Adminer**: `http://localhost:8081`
- **Host**: `mysql`
- **User**: `root`
- **Password**: `root`

### Email Testing
- **Mailpit**: `http://localhost:8025`
- **SMTP**: `localhost:1025`

### WP-CLI Commands
```bash
# Using the helper script (recommended)
./wpcli.sh plugin list
./wpcli.sh theme list
./wpcli.sh core version

# Or using docker compose directly
docker compose exec wpcli wp plugin list
```

---

## 🔧 Development Tools

### WP-CLI Integration

A powerful command-line interface for WordPress management is pre-configured and ready to use.

#### Quick Commands
```bash
# Plugin management
./wpcli.sh plugin list
./wpcli.sh plugin activate <plugin-name>
./wpcli.sh plugin install <plugin-name>

# Theme management  
./wpcli.sh theme list
./wpcli.sh theme activate <theme-name>
./wpcli.sh theme install <theme-name>

# Core operations
./wpcli.sh core version
./wpcli.sh core check-update
./wpcli.sh core update

# Database operations
./wpcli.sh db check
./wpcli.sh db backup
./wpcli.sh db optimize
```

### Xdebug Configuration

Xdebug is pre-configured for PHP debugging. Configure your IDE to connect to:

- **Host**: `localhost`
- **Port**: `9003`
- **Path Mapping**: `/var/www/html` → `./wp-content`

### Mailpit for Email Testing

All WordPress emails are caught and displayed in Mailpit:

- **Web Interface**: `http://localhost:8025`
- **SMTP Server**: `localhost:1025`
- **No configuration needed** - works out of the box!

---

## 📁 Project Structure

```
wordpress-docker/
├── 📄 docker-compose.yml          # Main Docker configuration
├── 📄 wpcli.sh                    # WP-CLI helper script
├── 📄 README.md                   # This file
├── 📄 WP-CLI-FIX.md              # Technical fix documentation
├── 📁 wp-content/                 # WordPress content (themes, plugins, uploads)
│   ├── 📁 plugins/               # Custom plugins
│   ├── 📁 themes/                # Custom themes  
│   └── 📁 uploads/               # Media files
├── 📁 php/                       # PHP configuration
│   └── 📄 xdebug.ini            # Xdebug settings
└── 📁 .gitignore                 # Git ignore rules
```

### Volume Mounts

- **`./wp-content`** → `/var/www/html/wp-content` (WordPress content)
- **`./php/xdebug.ini`** → `/usr/local/etc/php/conf.d/xdebug.ini` (PHP debugging)
- **`wordpress_files`** → `/var/www/html` (WordPress core files)

---

## 🔌 WP-CLI Commands

### Plugin Management
```bash
# List all plugins
./wpcli.sh plugin list

# Install a plugin
./wpcli.sh plugin install woocommerce

# Activate a plugin
./wpcli.sh plugin activate woocommerce

# Deactivate a plugin
./wpcli.sh plugin deactivate woocommerce

# Delete a plugin
./wpcli.sh plugin delete woocommerce

# Update a plugin
./wpcli.sh plugin update woocommerce
```

### Theme Management
```bash
# List all themes
./wpcli.sh theme list

# Install a theme
./wpcli.sh theme install generatepress

# Activate a theme
./wpcli.sh theme activate generatepress

# Delete a theme
./wpcli.sh theme delete generatepress
```

### Database Operations
```bash
# Database backup
./wpcli.sh db backup

# Database check
./wpcli.sh db check

# Database optimize
./wpcli.sh db optimize

# Search and replace
./wpcli.sh search-replace 'old-url.com' 'new-url.com'
```

### User Management
```bash
# List users
./wpcli.sh user list

# Create a user
./wpcli.sh user create admin admin@example.com --role=administrator

# Update user password
./wpcli.sh user update admin --user_pass=newpassword

# Delete a user
./wpcli.sh user delete admin --reassign=admin2
```

### Content Management
```bash
# List posts
./wpcli.sh post list

# Create a post
./wpcli.sh post create --post_title='Hello World' --post_content='Welcome to WordPress!'

# Delete a post
./wpcli.sh post delete 1 --force
```

---

## 🐛 Debugging

### Xdebug Setup

1. **Configure your IDE** (VS Code, PHPStorm, etc.)
   - Server: `localhost`
   - Port: `9003`
   - Path mapping: `/var/www/html` → `./wp-content`

2. **Enable Xdebug** (already configured)
   - Xdebug is automatically loaded from `./php/xdebug.ini`
   - No additional configuration needed

3. **Start Debugging**
   - Set breakpoints in your code
   - Start listening in your IDE
   - Access your WordPress site

### Common Debugging Commands

```bash
# Check PHP version and extensions
docker compose exec wp-app php -v
docker compose exec wp-app php -m

# View WordPress debug log
docker compose exec wp-app tail -f /var/www/html/wp-content/debug.log

# Check container logs
docker compose logs wordpress
docker compose logs mysql
docker compose logs wpcli
```

---

## 📝 Environment Variables

### Default Configuration

| Variable | Default Value | Description |
|----------|---------------|-------------|
| `MYSQL_ROOT_PASSWORD` | `root` | MySQL root password |
| `MYSQL_DATABASE` | `wordpress` | WordPress database name |
| `MYSQL_USER` | `wpuser` | WordPress database user |
| `MYSQL_PASSWORD` | `wppassword` | WordPress database password |
| `WORDPRESS_DB_HOST` | `mysql:3306` | Database host |
| `WORDPRESS_DB_NAME` | `wordpress` | WordPress database name |
| `WORDPRESS_DB_USER` | `wpuser` | WordPress database user |
| `WORDPRESS_DB_PASSWORD` | `wppassword` | WordPress database password |

### Custom Environment Variables

Create a `.env` file to override defaults:

```bash
# Database Configuration
MYSQL_ROOT_PASSWORD=your_secure_root_password
MYSQL_DATABASE=your_database_name
MYSQL_USER=your_database_user
MYSQL_PASSWORD=your_secure_password

# WordPress Configuration
WORDPRESS_DB_HOST=mysql:3306
WORDPRESS_DB_NAME=your_database_name
WORDPRESS_DB_USER=your_database_user
WORDPRESS_DB_PASSWORD=your_secure_password

# Development
WP_DEBUG=true
WP_DEBUG_LOG=true
```

---

## 🔄 Common Tasks

### Starting/Stopping Services

```bash
# Start all services
docker compose up -d

# Stop all services
docker compose down

# Restart specific service
docker compose restart wordpress

# View service logs
docker compose logs -f wordpress
```

### Database Management

```bash
# Access MySQL directly
docker compose exec mysql mysql -u root -p

# Create database backup
docker compose exec mysql mysqldump -u root -p wordpress > backup.sql

# Restore database from backup
docker compose exec -T mysql mysql -u root -p wordpress < backup.sql
```

### WordPress Updates

```bash
# Update WordPress core
./wpcli.sh core update

# Update all plugins
./wpcli.sh plugin update --all

# Update all themes
./wpcli.sh theme update --all
```

### Content Backup

```bash
# Export all content
./wpcli.sh export --all

# Export specific content type
./wpcli.sh export --post_type=post

# Import content
./wpcli.sh import content.xml
```

---

## 🚨 Troubleshooting

### Common Issues & Solutions

#### 🐛 WP-CLI Container Exits Immediately
**Problem**: WP-CLI container shows as exited
```bash
# Solution: Check container status and restart
docker compose ps
docker compose up -d wpcli
```

#### 🐛 Database Connection Errors
**Problem**: "Error establishing a database connection"
```bash
# Solution: Check MySQL container and wait for it to be ready
docker compose logs mysql
docker compose restart mysql
# Wait 30 seconds and try again
```

#### 🐛 WordPress Not Accessible
**Problem**: Site returns 404 or connection refused
```bash
# Solution: Check WordPress container and ports
docker compose ps
docker compose logs wordpress
# Ensure port 8080 is not in use by another application
```

#### 🐛 Xdebug Not Working
**Problem**: Breakpoints not being hit
```bash
# Solution: Verify Xdebug configuration
docker compose exec wp-app php -m | grep xdebug
# Check your IDE debugging configuration
```

#### 🐛 Volume Mount Issues
**Problem**: Changes to wp-content not reflected
```bash
# Solution: Check volume mounts and permissions
docker compose exec wp-app ls -la /var/www/html/wp-content
# Ensure local wp-content directory exists and is writable
```

### Getting Help

1. **Check Container Logs**
   ```bash
   docker compose logs [service-name]
   ```

2. **Verify Service Status**
   ```bash
   docker compose ps
   ```

3. **Test Individual Services**
   ```bash
   # Test WordPress
   curl -I http://localhost:8080
   
   # Test Database
   docker compose exec mysql mysql -u root -p -e "SHOW DATABASES;"
   
   # Test WP-CLI
   ./wpcli.sh --info
   ```

4. **Reset Environment**
   ```bash
   # Stop and remove all containers and volumes
   docker compose down -v
   
   # Restart fresh
   docker compose up -d
   ```

---

## 🤝 Contributing

We welcome contributions! Please follow these steps:

1. **Fork the Repository**
2. **Create a Feature Branch**
   ```bash
   git checkout -b feature/amazing-feature
   ```
3. **Make Your Changes**
4. **Test Thoroughly**
   ```bash
   docker compose down
   docker compose up -d
   # Run tests and verify functionality
   ```
5. **Commit Your Changes**
   ```bash
   git commit -m 'Add amazing feature'
   ```
6. **Push to Your Branch**
   ```bash
   git push origin feature/amazing-feature
   ```
7. **Open a Pull Request**

### Development Guidelines

- Follow WordPress coding standards
- Test all changes in the Docker environment
- Update documentation as needed
- Ensure all services work correctly

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🙏 Acknowledgments

- [WordPress](https://wordpress.org/) - The CMS that powers this project
- [Docker](https://www.docker.com/) - Container platform
- [WP-CLI](https://wp-cli.org/) - Command-line interface for WordPress
- [Mailpit](https://github.com/axllent/mailpit) - Email testing tool
- [Adminer](https://www.adminer.org/) - Database management tool

---

## 📞 Support

If you encounter any issues or have questions:

1. **Check the [Troubleshooting](#-troubleshooting) section**
2. **Search existing [Issues](../../issues)**
3. **Create a new Issue** with detailed information
4. **Join our Community** (link to Discord/Slack if available)

---

<div align="center">

**🌟 Star this repository if it helped you!**

Made with ❤️ for WordPress developers

[![Back to top](https://img.shields.io/badge/Back%20to%20top-↑-blue.svg)](#readme)

</div>