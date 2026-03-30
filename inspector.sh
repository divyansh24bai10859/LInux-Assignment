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
└─$ PACKAGE="git"

echo "================================================================"
echo "        FOSS Package Inspector                                  "
echo "================================================================"
echo ""
echo "  Checking package: $PACKAGE"
echo ""
================================================================
        FOSS Package Inspector
================================================================

  Checking package: git


┌──(DivyanshRai㉿DIVYANSH)-[/mnt/c/Users/raidi]
└─$
└─$ # ============================================================
if command -v rpm &>/dev/null && rpm -q "$PACKAGE" &>/dev/null; then
    # RPM-based system (Fedora, CentOS, RHEL)
    echo "  STATUS: $PACKAGE is INSTALLED (RPM-based system)"
    echo ""
    echo "  Package Details:"
    echo "  ----------------------------------------------------------------"
    rpm -qi "$PACKAGE" | grep -E "Version|License|Summary|URL" | \
        while IFS=: read -r KEY VAL; do
            printf "  %-12s: %s\n" "$KEY" "$VAL"
        done

elif command -v dpkg &>/dev/null && dpkg -l "$PACKAGE" 2>/dev/null | grep -q "^ii"; then
    # Debian-based system (Ubuntu, Debian)
    echo "  STATUS: $PACKAGE is INSTALLED (Debian-based system)"
    echo ""
    echo "  Package Details:"
    echo "  ----------------------------------------------------------------"
    dpkg -l "$PACKAGE" | grep "^ii" | awk '{printf "  Package : %s\n  Version : %s\n", $2, $3}'
    # Try to get more info from dpkg-query
    dpkg-query -W -f='  License  : See /usr/share/doc/${Package}/copyright\n  Summary  : ${Description}\n' "$PACKAGE" 2>/dev/null

elif command -v git &>/dev/null; then
    # Git is callable even if not in package manager (e.g. compiled from source)
    GIT_VERSION=$(git --version)
    echo "  STATUS: $PACKAGE is INSTALLED (found in PATH)"
    echo ""
    echo "  Package Details:"
    echo "  ----------------------------------------------------------------"
    echo "  Version  : $GIT_VERSION"
    echo "  License  : GPL v2"
    echo "  Summary  : Distributed version control system"

else
    # Package is NOT installed — print instructions
    echo "  STATUS: $PACKAGE is NOT INSTALLED"
    echo ""
    echo "  To install $PACKAGE, run one of the following:"
    echo "    RPM-based  : sudo dnf install $PACKAGE"
    echo "    Debian-based : sudo apt install $PACKAGE"
fi

echo ""
echo "================================================================"
echo "  OPEN SOURCE PHILOSOPHY NOTE"
echo "================================================================"
echo ""

# ============================================================
# Case statement: Print a philosophy note for each package
# This demonstrates the 'case' construct in bash
# ============================================================
case $PACKAGE in
    git)
        echo "  Git: Born from frustration — Linus Torvalds built this"
        echo "  when a proprietary tool (BitKeeper) revoked its free"
        echo "  license. Git is now the universal language of collaboration,"
        echo "  proving that open source can outlast any single vendor."
        ;;
    httpd | apache2)
        echo "  Apache: The web server that built the open internet."
        echo "  Running ~30% of all websites, Apache showed the world"
        echo "  that community-built software could beat corporate giants."
        ;;
    mysql | mariadb)
        echo "  MySQL/MariaDB: Open source at the heart of millions of apps."
        echo "  Its dual-license story (GPL + commercial) is a textbook"
        echo "  example of how businesses monetise open-source projects."
        ;;
    vlc)
        echo "  VLC: Built by students in Paris who simply wanted to stream"
        echo "  video. No corporate backing, no venture capital — just a"
        echo "  problem, a community, and a GPL license."
        ;;
    firefox)
        echo "  Firefox: A nonprofit fighting for an open web."
        echo "  Mozilla's browser is a reminder that market dominance"
        echo "  need not be the goal — protecting user freedom can be."
        ;;
    python3 | python)
        echo "  Python: A language shaped entirely by community consensus."
        echo "  PEPs (Python Enhancement Proposals) show that governance"
        echo "  and democracy matter as much as code in open source."
        ;;
    libreoffice)
        echo "  LibreOffice: Born from a community fork of OpenOffice."
        echo "  Its creation story is a lesson in what happens when"
        echo "  a corporate owner (Oracle) clashes with community values."
        ;;
    *)
        echo "  $PACKAGE: Every open-source tool carries a story of"
        echo "  someone deciding to share rather than hoard their work."
        echo "  That decision powers the modern digital world."
        ;;
esac

echo ""
echo "================================================================"
  STATUS: git is INSTALLED (Debian-based system)

  Package Details:
  ----------------------------------------------------------------
  Package : git
  Version : 1:2.51.0-1
  License  : See /usr/share/doc/git/copyright
  Summary  : fast, scalable, distributed revision control system
 Git is popular version control system designed to handle very large
 projects with speed and efficiency; it is used for many high profile
 open source projects, most notably the Linux kernel.
 .
 Git falls in the category of distributed source code management tools.
 Every Git working directory is a full-fledged repository with full
 revision tracking capabilities, not dependent on network access or a
 central server.
 .
 This package provides the git main components with minimal dependencies.
 Additional functionality, e.g. a graphical user interface and revision
 tree visualizer, tools for interoperating with other VCS's, or a web
 interface, is provided as separate git* packages.

================================================================
  OPEN SOURCE PHILOSOPHY NOTE
================================================================

  Git: Born from frustration — Linus Torvalds built this
  when a proprietary tool (BitKeeper) revoked its free
  license. Git is now the universal language of collaboration,
  proving that open source can outlast any single vendor.

================================================================

┌──(DivyanshRai㉿DIVYANSH)-[/mnt/c/Users/raidi]
└─$
