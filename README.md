# COP3710 MariaDB Development Environment

MariaDB DBMS container for GitHub Codespaces in COP3710 course.

## Overview

This repository provides a complete MariaDB database environment that runs automatically in GitHub Codespaces. The environment includes:

- Latest MariaDB server (automatically started on Codespaces launch)
- Pre-configured database users: root, red, blue, green, orange
- MySQL command-line client for terminal access
- SSH access on port 2222 for remote IDE connections (e.g., DataGrip)
- Sample database and table for testing

## Quick Start

1. Open this repository in GitHub Codespaces
2. Wait for the container to build (first time only, takes ~2-3 minutes)
3. The MariaDB server will be automatically started and configured
4. Use the MySQL client from the terminal or connect via SSH

## Database Connection Information

### Default Configuration

- **Host**: `localhost` or `127.0.0.1`
- **Port**: `3306`
- **Database**: `cop3710`

### User Accounts

| Username | Password    | Privileges                |
|----------|-------------|---------------------------|
| root     | rootpass    | Full administrative access|
| red      | redpass     | Full access to cop3710 DB |
| blue     | bluepass    | Full access to cop3710 DB |
| green    | greenpass   | Full access to cop3710 DB |
| orange   | orangepass  | Full access to cop3710 DB |

## Accessing MariaDB

### Command Line Access (Terminal)

The MySQL client is pre-installed in the Codespace. Connect using:

```bash
# Connect as root
mysql -u root -p -h 127.0.0.1

# Connect as other users
mysql -h 127.0.0.1 -u red -p 
mysql -h 127.0.0.1 -u blue -p
mysql -h 127.0.0.1 -u green -p 
mysql -h 127.0.0.1 -u orange -p 
```

### Common MySQL Commands

```sql
-- Show all databases
SHOW DATABASES;

-- Use the cop3710 database
USE cop3710;

-- Show all tables
SHOW TABLES;

-- Query the sample table
SELECT * FROM test_table;

-- Create a new table
CREATE TABLE students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100)
);

-- Exit MySQL
EXIT;
```

**📝 More Examples:** See [sample-queries.sql](sample-queries.sql) for comprehensive examples including:
- Creating tables with relationships
- JOIN operations
- Aggregate functions
- Sample data for testing

## Remote Access via DataGrip or Other IDEs

### SSH Configuration

The SSH server runs on port 2222 (the devcontainer sshd feature default) and is accessible for SSH connections. You'll need to configure your IDE to connect through the Codespaces SSH tunnel.

### DataGrip Setup

1. **Get your Codespace SSH connection details:**
   - In your Codespace, the SSH server is running on port 22
   - GitHub Codespaces provides port forwarding automatically
   - You can find the forwarded port URL in the "PORTS" tab at the bottom of VS Code

2. **Configure SSH Tunnel in DataGrip:**
   - Open DataGrip
   - Create a new Data Source (MariaDB)
   - Go to the "SSH/SSL" tab
   - Check "Use SSH tunnel"
   - Configure SSH settings:
     - Host: Your Codespace forwarded hostname
     - Port: The forwarded SSH port (shown in PORTS tab)
     - Auth type: Key pair (OpenSSH or PuTTY) or Password
     - Username: `vscode` (default Codespace user)

3. **Configure Database Connection:**
   - Go back to the "General" tab
   - Host: `localhost` (or `127.0.0.1`)
   - Port: `3306`
   - Database: `cop3710`
   - User: Choose from root, red, blue, green, or orange
   - Password: Use the corresponding password from the table above

4. **Test Connection**
   - Click "Test Connection" to verify everything works
   - If successful, click "OK" to save

### Connecting via GitHub CLI

You can also use the GitHub CLI to create an SSH tunnel:

```bash
# Install GitHub CLI (if not already installed)
# Then create a tunnel
gh codespace ports forward 3306:3306 -c YOUR_CODESPACE_NAME
```

Then connect directly to `localhost:3306` from your local machine.

## Environment Configuration

### Modifying User Accounts

To add or modify user accounts, edit `.devcontainer/init.sql`:

```sql
-- Add a new user
CREATE USER IF NOT EXISTS 'newuser'@'%' IDENTIFIED BY 'newpass';
GRANT ALL PRIVILEGES ON cop3710.* TO 'newuser'@'%';
FLUSH PRIVILEGES;
```

After modifying, rebuild the container:
- Command Palette (Ctrl+Shift+P / Cmd+Shift+P)
- Select "Codespaces: Rebuild Container"

### Changing Database Configuration

Edit `.devcontainer/docker-compose.yml` to modify:
- Root password (MYSQL_ROOT_PASSWORD)
- Default database name (MYSQL_DATABASE)
- MariaDB version (change `mariadb:latest` to specific version)

### Port Configuration

Ports 3306 (MariaDB) and 2222 (SSH) are automatically forwarded in Codespaces. You can view and manage port forwarding in the "PORTS" tab of VS Code.

## Sample Database Schema

The environment includes a sample table for testing:

```sql
CREATE TABLE test_table (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

With sample data:
- Sample Entry 1
- Sample Entry 2
- Sample Entry 3

## Verifying Your Setup

A verification script is included to test that all components are properly configured:

```bash
bash .devcontainer/verify-setup.sh
```

This script will check:
- MySQL client installation
- MariaDB server connectivity
- Database existence
- All user accounts (root, red, blue, green, orange)
- Sample table and data
- Port accessibility
- SSH server status

## Troubleshooting

### MariaDB not responding

```bash
# Check if MariaDB is running
mysql -h 127.0.0.1 -u root -prootpass -e "SELECT 1"

# If not, check Docker container status
docker ps
```

### Cannot connect from terminal

Make sure you're using `127.0.0.1` instead of `localhost` in some cases:

```bash
mysql -h 127.0.0.1 -u root -prootpass cop3710
```

### SSH connection issues

1. Check that port 2222 is forwarded in the PORTS tab
2. Verify the SSH server is running: `sudo service ssh status`
3. If needed, restart SSH: `sudo service ssh restart`

### Rebuilding the Environment

If you encounter persistent issues:

1. Command Palette (Ctrl+Shift+P / Cmd+Shift+P)
2. Select "Codespaces: Rebuild Container"
3. Wait for the rebuild to complete

## File Structure

```
.
├── .devcontainer/
│   ├── devcontainer.json      # Codespaces configuration
│   ├── docker-compose.yml     # Docker services definition
│   ├── init.sql               # Database initialization script
│   ├── post-create.sh         # Post-creation setup script
│   └── verify-setup.sh        # Environment verification script
└── README.md                  # This file
```

## Additional Resources

- [MariaDB Documentation](https://mariadb.com/kb/en/documentation/)
- [MariaDB SQL Statements Reference](https://mariadb.com/kb/en/sql-statements/)
- [GitHub Codespaces Documentation](https://docs.github.com/en/codespaces)

## Support

For issues specific to this course environment, please contact your instructor or TA.
