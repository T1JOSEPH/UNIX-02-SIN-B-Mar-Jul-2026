# ============================================================================
# Dockerfile used to build the course development container
# ============================================================================
# A Dockerfile is a text file containing instructions that Docker reads
# from top to bottom to create an image. An image is a reusable template
# that contains an operating system, installed software and configuration.
#
# When a container starts, Docker creates it from the image. The image
# remains unchanged and can be used to create multiple containers.
#
# Docker builds images in layers. Each instruction creates a new layer
# that can be cached and reused during future builds. This makes rebuilds
# faster when previous instructions have not changed.
# (Black Hat Bash Ch.3: Docker images and containers)
# ============================================================================

# ----------------------------------------------------------------------------
# FROM: define the base image
# ----------------------------------------------------------------------------
# The FROM instruction selects the starting image used for the build.
# Kali Linux is chosen because it already includes many networking,
# security and command-line tools commonly used in cybersecurity labs.
# The rolling version receives continuous updates.
# (Black Hat Bash Ch.3: Kali Linux lab environment)
FROM kalilinux/kali-rolling:latest

# ----------------------------------------------------------------------------
# ENV: environment variables
# ----------------------------------------------------------------------------
# Environment variables store configuration values that can be accessed
# by programs and shell sessions inside the container.
#
# DEBIAN_FRONTEND=noninteractive prevents package installers from asking
# interactive questions during automated builds.
#
# LANG and LC_ALL define the default language and UTF-8 character encoding.
# UTF-8 ensures proper handling of accented characters and special symbols.
#
# TERM=xterm-256color informs terminal applications that 256-color support
# is available.
#
# The "\" character continues the instruction on the next line to improve
# readability.
# (Black Hat Bash Ch.1: environment variables)
ENV DEBIAN_FRONTEND=noninteractive \
    LANG=es_ES.UTF-8 \
    LC_ALL=es_ES.UTF-8 \
    TERM=xterm-256color

# ----------------------------------------------------------------------------
# Configure Wireshark installation in advance
# ----------------------------------------------------------------------------
# Some packages normally display questions during installation.
# debconf-set-selections allows predefined answers to be supplied before
# installation begins.
#
# This prevents the build process from stopping and waiting for user input.
# Since the container runs as root, packet capture permissions for normal
# users are not required.
RUN echo "wireshark-common wireshark-common/install-setuid boolean false" \
    | debconf-set-selections
    
# ----------------------------------------------------------------------------
# Basic UNIX utilities 
# ----------------------------------------------------------------------------
# These packages provide many of the commands that are commonly used
# in Linux systems and shell scripting.
#
# coreutils includes commands such as cat, ls, head, tail, sort,
# cut and tr. I will probably use these commands constantly when
# working with files and text from the terminal.
#
# findutils provides tools such as find and xargs. They are useful
# for locating files and performing operations on multiple files at
# the same time.
#
# procps contains commands related to process management, including
# ps, top and kill. These tools help monitor and control running
# processes.
#
# less is a pager that makes it easier to read large files directly
# from the terminal without opening a text editor.
#
# tree displays directories using a tree structure, which helps me
# understand how files and folders are organized.
#
# jq is a command-line tool used to read, filter and manipulate JSON
# data. Since many modern tools return information in JSON format,
# jq is extremely useful.
#
# (Black Hat Bash Ch.1 and Ch.2: command-line tools and text processing)
coreutils \
findutils \
procps \
less \
tree \
jq \

# === Manual pages (man command) ===
# Many Docker images remove documentation to save disk space.
# I install these packages because the man command is one of the
# most useful learning resources available directly from the terminal.
#
# During the course I can use commands such as:
#   man bash
#   man grep
#   man sed
# to read detailed documentation without needing a web browser.
#
# man-db provides the man command itself, while the other packages
# contain the documentation files.
man-db \
manpages \
manpages-posix \

# === Basic networking and download tools ===
# These packages provide utilities that are commonly used when working
# with networks, repositories and remote resources.
#
# curl and wget are tools used to download files or communicate with
# web servers directly from the terminal. They are useful for testing
# HTTP requests and downloading resources.
#
# git is the version control system used throughout the course to
# track changes and collaborate on projects.
#
# git-lfs (Git Large File Storage) extends Git so that large files
# can be managed more efficiently without making repositories grow
# excessively.
#
# ca-certificates provides trusted certificate authorities that allow
# HTTPS connections to be verified securely.
#
# locales contains language and regional settings that will later be
# configured for the container.
curl \
wget \
git \
git-lfs \
ca-certificates \
locales \

# === Shell script analysis ===
# ShellCheck is a static analysis tool for shell scripts.
# It helps detect syntax mistakes, bad practices and common bugs
# before running a script.
#
# During the course it can be used to improve Bash scripts and avoid
# many common errors.
shellcheck \

# === Network reconnaissance and scanning ===
# Nmap is one of the most popular network scanning tools. It can be
# used to discover hosts, identify services and detect open ports.
#
# Masscan performs high-speed scans and is useful when working with
# very large IP ranges.
#
# These tools are frequently used during network analysis and
# cybersecurity exercises.
nmap \
masscan \

# === Packet capture and network analysis ===
# tcpdump is a classic command-line packet capture tool. It allows
# network traffic to be inspected directly from the terminal.
#
# tshark is the command-line version of Wireshark. It provides many
# of the same analysis capabilities without requiring a graphical
# interface.
#
# These tools are useful for understanding how protocols work and
# for analyzing network communications.
tcpdump \
tshark \

# === Additional networking utilities ===
# netcat is often called the "Swiss Army knife" of networking because
# it can create connections, listen on ports and transfer data.
#
# socat is similar to netcat but supports more advanced networking
# scenarios.
#
# dnsutils provides tools such as dig and nslookup for DNS queries.
#
# whois allows information about domains and IP addresses to be
# retrieved.
#
# traceroute and mtr help analyze the path that packets follow across
# networks.
#
# iproute2 and net-tools provide commands for configuring and viewing
# network interfaces.
#
# iputils-ping includes the ping command used to test connectivity.
netcat-traditional \
socat \
dnsutils \
whois \
traceroute \
mtr-tiny \
iproute2 \
net-tools \
iputils-ping \

# === Privacy and anonymity tools ===
# Tor is a network designed to increase privacy by routing traffic
# through multiple relays.
#
# torsocks can force certain applications to send their traffic
# through the Tor network.
#
# proxychains4 allows commands to be routed through one or more
# proxies.
#
# obfs4proxy helps disguise Tor traffic so that it is more difficult
# to identify or block.
#
# These tools are useful for learning about privacy technologies and
# alternative routing methods.
tor \
torsocks \
proxychains4 \
obfs4proxy \

# === User-friendly HTTP client ===
# HTTPie is an HTTP client designed to be easier to read and use than
# traditional command-line tools.
#
# It is useful for learning how HTTP requests and responses work
# because the output is presented in a more readable format.
httpie \
\
# --- Enable Spanish locale after installation ---
# After installing all required packages, I enable the Spanish locale.
#
# The sed command edits the locale configuration file directly.
# It finds the Spanish locale entry and removes the "#" character
# that keeps it disabled.
#
# Once the locale has been enabled, locale-gen creates the files
# needed for the operating system to use that language and regional
# configuration correctly.
#
# (Black Hat Bash Ch.2: text processing with sed)
&& sed -i 's/# es_ES.UTF-8/es_ES.UTF-8/' /etc/locale.gen \
&& locale-gen \
\
# --- Final cleanup ---
# Package installation leaves temporary files and cached package data.
#
# These files are useful during installation but are no longer needed
# once the build process is complete.
#
# I remove them to reduce the final image size and keep the container
# lighter.
#
# Doing this cleanup inside the same RUN instruction is important
# because Docker stores each RUN as a separate layer. If the cleanup
# happened later, the old layer would still contain those files.
#
# (Black Hat Bash Ch.3: Docker layers and image optimization)
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

# ----------------------------------------------------------------------------
# SHELL: choose the shell used by future RUN instructions
# ----------------------------------------------------------------------------
# Docker normally executes RUN commands using /bin/sh.
#
# In this container I switch to Bash because it provides more scripting
# features and is the shell used throughout Black Hat Bash.
#
# Bash supports things such as arrays, improved conditional statements
# and additional shell functionality that may not be available in a
# basic sh environment.
#
# Using Bash also keeps the environment consistent with the examples
# and exercises used during the course.
#
# (Black Hat Bash Ch.1: Bash shell fundamentals)
SHELL ["/bin/bash", "-c"]

# ----------------------------------------------------------------------------
# WORKDIR: define the default working directory
# ----------------------------------------------------------------------------
# WORKDIR sets the directory where commands will run by default inside
# the container.
#
# Instead of manually using "cd" every time a terminal opens, Docker
# automatically starts in this location.
#
# Codespaces usually mounts repositories inside the /workspaces folder,
# so choosing this directory makes it easier to access course files
# immediately after opening the container.
#
# This saves time and provides a consistent starting location for all
# users working in the development environment.
WORKDIR /workspaces

# ----------------------------------------------------------------------------
# Git configuration
# ----------------------------------------------------------------------------
# In this step I configure Git for the entire container.
#
# safe.directory '*' tells Git to trust repositories mounted from
# Codespaces or Docker volumes. This prevents ownership warnings that
# can appear when the repository owner inside the container is different
# from the original owner on the host system.
#
# init.defaultBranch main makes Git create new repositories using
# "main" as the default branch name instead of older defaults.
#
# pull.rebase false keeps the standard merge behavior when running
# git pull. I find this easier to understand than automatic rebasing.
#
# git lfs install --system enables Git Large File Storage globally.
# This allows repositories that use large files to work correctly
# without requiring additional setup.
RUN git config --system --add safe.directory '*' \
 && git config --system init.defaultBranch main \
 && git config --system pull.rebase false \
 && git lfs install --system

# ----------------------------------------------------------------------------
# Change the default shell
# ----------------------------------------------------------------------------
# By default many Linux systems start with Bash.
#
# Here I change the default login shell for the root user to Zsh.
#
# Zsh provides additional customization features, improved tab
# completion and a more flexible command-line experience.
#
# This means that new terminal sessions will automatically start
# using Zsh instead of Bash.
#
# (Black Hat Bash Ch.1: shells and command interpreters)
RUN chsh -s /usr/bin/zsh root

# ----------------------------------------------------------------------------
# Configure the Zsh environment
# ----------------------------------------------------------------------------
# Here I use a heredoc to append several lines directly into the
# .zshrc configuration file.
#
# The <<'EOF' syntax is called a here-document. It allows multiple
# lines of text to be redirected into a command without creating
# a separate temporary file.
#
# The quotes around EOF prevent variables from being expanded while
# the text is being written.
#
# (Black Hat Bash Ch.1: shell input and redirection)
RUN cat >> /root/.zshrc <<'EOF'

# Custom prompt used in the course environment.
#
# The prompt displays the username, the current directory and the
# result of the previous command.
#
# Colors are used to make important information easier to identify
# while working in the terminal.
PROMPT='%F{cyan}[Jose]%f %F{yellow}%1~%f %(?.%F{green}ok%f.%F{red}notok %?%f) %# '
EOF


CMD ["/usr/bin/zsh"]


