# WP-CLI Docker Setup - Fixed Issues

## Problems Fixed

1. **Container Exit Behavior**: WP-CLI container was exiting immediately after showing help
2. **Volume Mounting**: Incorrect volume configuration prevented access to WordPress files
3. **Database Connection**: Missing environment variables for database connectivity
4. **Network Configuration**: WP-CLI couldn't communicate with WordPress and MySQL containers

## Changes Made

### 1. Docker Compose Configuration
- **Fixed volume mounting**: Created shared `wordpress_files` volume for both WordPress and WP-CLI containers
- **Added environment variables**: WP-CLI now has same database credentials as WordPress
- **Fixed entrypoint**: Changed from `wp` to `sh -c 'tail -f /dev/null'` to keep container running
- **Corrected MySQL volumes**: Fixed MySQL volume mounting to use `mysql_data` instead of `wordpress_data`

### 2. Helper Script
- Created `wpcli.sh` script for easier WP-CLI command execution
- Provides usage examples and help information

## Usage

### Direct Docker Compose Commands
```bash
# List plugins
docker compose exec wpcli wp plugin list

# List themes  
docker compose exec wpcli wp theme list

# Check WordPress version
docker compose exec wpcli wp core version
```

### Using Helper Script
```bash
# List plugins
./wpcli.sh plugin list

# List themes
./wpcli.sh theme list

# Check WordPress version
./wpcli.sh core version
```

## Verification

All WP-CLI commands are now working:
- ✅ Core commands (version, check-update)
- ✅ Plugin management (list, activate, deactivate)
- ✅ Theme management (list, activate, switch)
- ✅ Database operations
- ✅ Configuration management

## Container Status

All containers are running properly:
- wp-app: WordPress application (port 8080)
- wp-mysql: MySQL database (port 3306)
- wpcli: WP-CLI interface (persistent container)
- wp-adminer: Database admin (port 8081)
- wp-mailpit: Email testing (ports 1025, 8025)