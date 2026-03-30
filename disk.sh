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
echo "        Disk and Permission Auditor                             "
echo "================================================================"
echo ""
echo "  Auditing standard system directories using a for loop..."
echo ""
printf "  %-20s %-25s %-10s %-10s\n" "Directory" "Permissions/Owner/Group" "Size" "Status"
echo "  ----------------------------------------------------------------------------"

# ============================================================
# FOR LOOP: Iterate over each directory in the DIRS array
# For each directory: check existence, get permissions, size
# ============================================================
for DIR in "${DIRS[@]}"; do
    if [ -d "$DIR" ]; then
        # Extract permissions, owner, and group using ls and awk
        # awk '{print $1, $3, $4}' extracts: perms, owner, group
        PERMS=$(ls -ld "$DIR" | awk '{print $1}')
        OWNER=$(ls -ld "$DIR" | awk '{print $3}')
        GROUP=$(ls -ld "$DIR" | awk '{print $4}')

        # Get human-readable directory size
        # 2>/dev/null suppresses permission-denied errors
        SIZE=$(du -sh "$DIR" 2>/dev/null | cut -f1)

        # Print formatted row
        printf "  %-20s %-10s %-8s %-8s %-10s %s\n" \
            "$DIR" "$PERMS" "$OWNER" "$GROUP" "${SIZE:-N/A}" "OK"
    else
        # Directory does not exist on this system
        printf "  %-20s %-25s %-10s %s\n" \
            "$DIR" "N/A" "N/A" "NOT FOUND"
    fi
done

echo ""
echo "================================================================"
echo "  GIT-SPECIFIC CONFIGURATION FILE AUDIT"
echo "  (Chosen software: Git)"
echo "================================================================"
echo ""

# ============================================================
# Check Git's system-wide config file and user config
# This section fulfils the TODO: check software config
# ============================================================

# Check system-wide git config
if [ -f "$GIT_SYSTEM_CONFIG" ]; then
    PERMS=$(ls -l "$GIT_SYSTEM_CONFIG" | awk '{print $1, $3, $4}')
    SIZE=$(du -sh "$GIT_SYSTEM_CONFIG" 2>/dev/null | cut -f1)
    echo "  System config : $GIT_SYSTEM_CONFIG"
    echo "  Permissions   : $PERMS"
    echo "  Size          : ${SIZE:-tiny}"
    echo ""
else
    echo "  System config ($GIT_SYSTEM_CONFIG) : NOT FOUND"
    echo "  (Git may be installed but no system-wide config set yet)"
    echo ""
fi

# Check user-level git config
if [ -f "$GIT_USER_CONFIG" ]; then
    PERMS=$(ls -l "$GIT_USER_CONFIG" | awk '{print $1, $3, $4}')
    echo "  User config   : $GIT_USER_CONFIG"
    echo "  Permissions   : $PERMS"
else
    echo "  User config ($GIT_USER_CONFIG) : NOT FOUND"
    echo "  (Run 'git config --global user.name' to create it)"
fi

echo ""
echo "================================================================"
echo "  WHY PERMISSIONS MATTER IN OPEN SOURCE"
echo "================================================================"
echo ""
echo "  Linux permissions are a direct expression of open-source values:"
echo "  - /etc (755): Readable by all — transparency in configuration"
echo "  - /var/log (755/750): Logs visible to admins — auditability"
echo "  - /home (755): Each user owns their space — personal freedom"
echo "  - /tmp (1777): Sticky bit — shared but protected"
echo ""
echo "================================================================"
================================================================
        Disk and Permission Auditor
================================================================

  Auditing standard system directories using a for loop...

  Directory            Permissions/Owner/Group   Size       Status
  ----------------------------------------------------------------------------

================================================================
  GIT-SPECIFIC CONFIGURATION FILE AUDIT
  (Chosen software: Git)
================================================================

  System config () : NOT FOUND
  (Git may be installed but no system-wide config set yet)

  User config () : NOT FOUND
  (Run 'git config --global user.name' to create it)

================================================================
  WHY PERMISSIONS MATTER IN OPEN SOURCE
================================================================

  Linux permissions are a direct expression of open-source values:
  - /etc (755): Readable by all — transparency in configuration
  - /var/log (755/750): Logs visible to admins — auditability
  - /home (755): Each user owns their space — personal freedom
  - /tmp (1777): Sticky bit — shared but protected

================================================================

┌──(DivyanshRai㉿DIVYANSH)-[/mnt/c/Users/raidi]
└─$
