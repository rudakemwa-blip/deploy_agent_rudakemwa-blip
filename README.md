# Attendance Deployment Agent

# Overview
This Bash script automates the setup and management of an attendance tracking project. It checks for Python 3 and required templates, creates the project directory structure, configures attendance thresholds, and launches the attendance checker.

# Requirements
- Bash
- Python 3
- zip utility

# How to Run
Run the script from the project directory:

```bash
bash deploy_agent.sh
```

Choose an option from the menu:

1. **Deploy:** Create a new attendance tracker project using the supplied templates or a sample roster.
2. **Run:** Run an existing attendance tracker project.
3. **Archive:** Archive attendance and absent logs when those files exist.
4. **Exit:** Close the program.

# Configuration
During deployment, enter warning and critical thresholds as whole numbers between 0 and 100.

# Signal Handling
During deployment, the script handles SIGINT (Ctrl+C) and SIGTSTP (Ctrl+Z). It attempts to create a ZIP archive of an incomplete project and remove the incomplete directory only if archiving succeeds.
# Project Structure
The deployed project contains the attendance checker, a Helpers directory for configuration and roster data, and a reports directory.
# Limitations
Log archiving requires the attendance checker to generate `attendance.log` and `absent.log` in the deployed project directory. If those files are absent, the script reports that no logs were found.
