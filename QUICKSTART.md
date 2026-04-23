# 🚀 Quick Start Guide

Welcome to your COP3710 MariaDB Development Environment!

## ✅ What's Already Configured

Your environment is ready to use with:
- ✅ MariaDB server running (latest version)
- ✅ 5 user accounts created and ready
- ✅ MySQL command-line client installed
- ✅ SSH server for remote access (port 2222)
- ✅ Sample database with test data

## 🎯 Getting Started (30 seconds)

### Test Your Connection

Run this command in the terminal:

```bash
mysql -h 127.0.0.1 -u root -prootpass cop3710
```

Once connected, try:
```sql
SHOW TABLES;
SELECT * FROM test_table;
```

Type `EXIT;` to disconnect.

## 👥 Your User Accounts

| Username | Password    |
|----------|-------------|
| root     | rootpass    |
| red      | redpass     |
| blue     | bluepass    |
| green    | greenpass   |
| orange   | orangepass  |

## 🔍 Verify Everything Works

Run the verification script:
```bash
bash .devcontainer/verify-setup.sh
```

## 📚 Need More Help?

See the complete [README.md](README.md) for:
- DataGrip configuration instructions
- SSH setup for remote access
- Common MySQL commands
- Troubleshooting tips
- Environment customization

## 🎓 Course Information

This environment is designed for COP3710 course work. All user accounts have full access to the `cop3710` database for your assignments.

---

**Pro Tip:** Keep this Codespace running while working on assignments. MariaDB data persists between sessions!
