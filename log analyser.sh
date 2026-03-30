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
└─$ echo "================================================================"
echo "        Log File Analyzer                                       "
echo "================================================================"
echo ""

# ============================================================
# Validate: Check if a log file argument was provided
# ============================================================
if [ -z "$LOGFILE" ]; then
    echo "  ERROR: No log file specified."
    echo "  Usage: $0 /path/to/logfile [keyword]"
    echo ""
    echo "  Common log files to try:"
    echo "    /var/log/syslog      (Ubuntu/Debian)"
    echo "    /var/log/messages    (Fedora/CentOS)"
    echo "    /var/log/auth.log    (Authentication events)"
    exit 1
fi

# ============================================================
# Validate: Check if the log file exists and is readable
# ============================================================
if [ ! -f "$LOGFILE" ]; then
    echo "  ERROR: File '$LOGFILE' not found."
    echo ""

    # --- DO-WHILE style RETRY: suggest an alternate log file ---
    # Bash has no native do-while, so we simulate with a while loop
    # and an initial condition set to true
    RETRY=true
    ATTEMPT=0
    MAX_ATTEMPTS=3

    while $RETRY; do
        ATTEMPT=$((ATTEMPT + 1))
        echo "  Retry attempt $ATTEMPT of $MAX_ATTEMPTS..."

        # Try common fallback log file locations
        case $ATTEMPT in
            1) FALLBACK="/var/log/syslog" ;;
            2) FALLBACK="/var/log/messages" ;;
            3) FALLBACK="/var/log/kern.log" ;;
        esac

        if [ -f "$FALLBACK" ]; then
            echo "  Found fallback log file: $FALLBACK"
            LOGFILE="$FALLBACK"
            RETRY=false   # Stop retrying — we found a valid file
        elif [ $ATTEMPT -ge $MAX_ATTEMPTS ]; then
            echo "  No fallback log files found after $MAX_ATTEMPTS attempts."
            echo "  Please provide a valid log file path."
            exit 1
        fi
    done
fi

# ============================================================
# Check if the file is empty; warn but continue
# ============================================================
if [ ! -s "$LOGFILE" ]; then
    echo "  WARNING: '$LOGFILE' is empty. No lines to analyse."
    exit 0
fi

echo "  Log File : $LOGFILE"
echo "  Keyword  : '$KEYWORD' (case-insensitive)"
echo ""
echo "  Scanning file..."
echo ""

# ============================================================
# WHILE READ LOOP: Read the log file line by line
# IFS= preserves leading/trailing whitespace in each line
# -r prevents backslash interpretation
# ============================================================
while IFS= read -r LINE; do
    # IF-THEN: Check if the current line contains our keyword
    # grep -iq = case-insensitive, quiet (no output, just exit code)
    if echo "$LINE" | grep -iq "$KEYWORD"; then
        COUNT=$((COUNT + 1))             # Increment counter
        MATCH_LINES+=("$LINE")           # Add to match array
    fi
done < "$LOGFILE"   # Redirect file into the while loop (not piped, preserving subshell)

# ============================================================
# Display results
# ============================================================
echo "  ----------------------------------------------------------------"
echo "  SUMMARY"
echo "  ----------------------------------------------------------------"
echo "  Keyword '$KEYWORD' found : $COUNT time(s) in $LOGFILE"
echo ""

# ============================================================
# Print last 5 matching lines using array slicing
# ${#MATCH_LINES[@]} = total count; we show last 5
# ============================================================
if [ $COUNT -gt 0 ]; then
    echo "  Last 5 matching lines:"
    echo "  ----------------------------------------------------------------"

    # Calculate start index for last 5 entries
    TOTAL=${#MATCH_LINES[@]}
    START=$(( TOTAL > 5 ? TOTAL - 5 : 0 ))

    # Loop from START to end of array
    for (( i=START; i<TOTAL; i++ )); do
        # Truncate long lines at 100 chars for clean display
        DISPLAY_LINE="${MATCH_LINES[$i]:0:100}"
        echo "  [$(( i - START + 1 ))] $DISPLAY_LINE"
    done
    echo ""
else
    echo "  No lines matched the keyword '$KEYWORD'."
    echo "  Try a different keyword: ./$(basename $0) $LOGFILE WARNING"
fi

echo "================================================================"
================================================================
        Log File Analyzer
================================================================

  ERROR: No log file specified.
  Usage: -bash /path/to/logfile [keyword]

  Common log files to try:
    /var/log/syslog      (Ubuntu/Debian)
    /var/log/messages    (Fedora/CentOS)
    /var/log/auth.log    (Authentication events)
logout
PS C:\Users\raidi>
