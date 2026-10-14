#!/bin/bash

echo "Enter project name suffix:"
read project_name

BASE_DIR="attendance_tracker_${project_name}"
ARCHIVE_NAME="attendance_tracker_${project_name}_archive.tar.gz"

cleanup() {

    echo ""
    echo "CTRL+C detected!"

    if [ -d "$BASE_DIR" ]; then

        tar -czf "$ARCHIVE_NAME" "$BASE_DIR"

        echo "Archive created."

        rm -rf "$BASE_DIR"

        echo "Incomplete directory deleted."
    fi

    exit 1
}

trap cleanup SIGINT

if [ -d "$BASE_DIR" ]; then
    echo "Directory already exists!"
    exit 1
fi

echo "Creating folders..."

mkdir -p "$BASE_DIR/Helpers"
mkdir -p "$BASE_DIR/reports"

cp attendance_checker.py "$BASE_DIR/"
cp assets.csv "$BASE_DIR/Helpers/"
cp config.json "$BASE_DIR/Helpers/"
cp reports.log "$BASE_DIR/reports/"

echo "Do you want to update thresholds? (yes/no)"
read answer

if [ "$answer" = "yes" ]; then

    while true; do
        echo "Enter warning threshold:"
        read warning

        if [[ "$warning" =~ ^[0-9]+$ ]]; then
            break
        else
            echo "Numbers only!"
        fi
    done

    while true; do
        echo "Enter failure threshold:"
        read failure

        if [[ "$failure" =~ ^[0-9]+$ ]]; then
            break
        else
            echo "Numbers only!"
        fi
    done

    CONFIG_FILE="$BASE_DIR/Helpers/config.json"

    sed -i "s/\"warning_threshold\": *[0-9]*/\"warning_threshold\": $warning/" "$CONFIG_FILE"

    sed -i "s/\"failure_threshold\": *[0-9]*/\"failure_threshold\": $failure/" "$CONFIG_FILE"

    echo "Config updated."
fi

echo "Running health check..."

if python3 --version >/dev/null 2>&1; then
    echo "Python3 installed."
    python3 --version
else
    echo "Python3 missing."
fi

if [ -f "$BASE_DIR/attendance_checker.py" ] &&
   [ -f "$BASE_DIR/Helpers/assets.csv" ] &&
   [ -f "$BASE_DIR/Helpers/config.json" ] &&
   [ -f "$BASE_DIR/reports/reports.log" ]; then

    echo "Structure validated."

else
    echo "Structure invalid."
fi

echo "Project setup complete."
