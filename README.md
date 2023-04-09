# linSec

Bash script to add basic security tools to a standard Debian-based Linux distribution.

This also adds Zsh as the main shell, and decorates it in the style of Kali Linux.

Currently adds JDK version 20 and Burpsuite Community 2023.3.2.

Using snap to install john-the-ripper & metasploit (much more recent release compared to apt).

Creates a directory labeled 'tools' for the installationg of most of the tools, and a directory labeled 'wordlists' for SecLists -- all in the home directory.
---
### Installation
To install just run;
`sudo ./linSec.sh`

---
Only tested on ZorinOS 16.2.
