Windows PowerShell
Copyright (C) Microsoft Corporation. All rights reserved.

Install the latest PowerShell for new features and improvements! https://aka.ms/PSWindows

PS C:\Users\raidi> wsl
┏━(Message from Kali developers)
┃
┃ This is a minimal installation of Kali Linux, you likely
┃ want to install supplementary tools. Learn how:
┃ ⇒ https://www.kali.org/docs/troubleshooting/common-minimum-setup/
┃
┗━(Run: “touch ~/.hushlogin” to hide this message)
┌──(DivyanshRai㉿DIVYANSH)-[/mnt/c/Users/raidi]
└─$
└─$ print_divider() {
    echo "================================================================"
}

print_section() {
    echo ""
    echo "  --- $1 ---"
    echo ""
}

# ============================================================
# Welcome screen
# ============================================================
clear
print_divider
echo "        Open Source Manifesto Generator                        "
print_divider
echo ""
echo "  This script will generate a personalised open-source"
echo "  philosophy statement based on your answers."
echo "  Your manifesto will be saved as a .txt file."
echo ""
print_divider
echo ""

# ============================================================
# Interactive user input using 'read'
# The -p flag shows a prompt inline
# ============================================================
read -p "  1. Name one open-source tool you use every day: " TOOL
echo ""
read -p "  2. In one word, what does 'freedom' mean to you? " FREEDOM
echo ""
read -p "  3. Name one thing you would build and share freely: " BUILD
echo ""

# ============================================================
# Validate inputs — ensure user actually entered something
# ============================================================
if [ -z "$TOOL" ] || [ -z "$FREEDOM" ] || [ -z "$BUILD" ]; then
    echo "  ERROR: Please answer all three questions."
    echo "  Run the script again and fill in each response."
    exit 1
fi

# ============================================================
# Date and output file setup
# ============================================================
DATE=$(date '+%d %B %Y')                     # e.g. 23 March 2026
TIME=$(date '+%H:%M')                        # e.g. 14:32
USERNAME=$(whoami)                           # Current Linux user
OUTPUT="manifesto_${USERNAME}.txt"           # Output filename

# ============================================================
# String concatenation: Build the manifesto paragraph
# Using echo with >> to append each line to the file
# > overwrites; >> appends
# ============================================================

# Start fresh — overwrite if file already exists
echo "OPEN SOURCE MANIFESTO" > "$OUTPUT"
echo "Generated on $DATE at $TIME by $USERNAME" >> "$OUTPUT"
echo "================================================================" >> "$OUTPUT"
echo "" >> "$OUTP
