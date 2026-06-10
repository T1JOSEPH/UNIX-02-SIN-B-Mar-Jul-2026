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

# === Red básica y utilidades de descarga ===
    curl \
    wget \
    git \
    git-lfs \
    ca-certificates \
    locales \
    \
    # === Linter (revisor automático de errores) para scripts Bash ===
    shellcheck \
    \
    # === Reconocimiento y escaneo de red ===
    # nmap = el escáner de puertos más famoso.
    # masscan = escaneo masivo de rangos grandes de IPs.
    nmap \
    masscan \
    \
    # === Captura y análisis de paquetes de red ===
    # tcpdump = capturador clásico por terminal.
    # tshark = versión de terminal de Wireshark.
    tcpdump \
    tshark \
    \
    # === Utilidades de red variadas ===
    netcat-traditional \
    socat \
    dnsutils \
    whois \
    traceroute \
    mtr-tiny \
    iproute2 \
    net-tools \
    iputils-ping \
    \
    # === Anonimato: Tor y similares ===
    # tor = cliente de la red Tor.
    # torsocks = "envoltorio" que hace pasar cualquier comando por Tor.
    # proxychains4 = encadena múltiples proxies.
    # obfs4proxy = ofusca el tráfico de Tor para evadir bloqueos.
    tor \
    torsocks \
    proxychains4 \
    obfs4proxy \
    \
    # === Cliente HTTP más legible que curl para aprender ===
    httpie \
    \
 # --- Después de instalar, activamos el idioma español ---
 # sed busca "# es_ES.UTF-8" en /etc/locale.gen y le quita el "#" para
 # activar esa línea. Luego locale-gen compila los archivos de idioma.
 && sed -i 's/# es_ES.UTF-8/es_ES.UTF-8/' /etc/locale.gen \
 && locale-gen \
 \
 # --- Limpieza final: reducir el tamaño de la imagen ---
 # apt deja archivos de caché que ya no necesitamos después de instalar.
 # Borrarlos aquí (en el mismo RUN) hace la capa final más pequeña.
 # Si los borráramos en otro RUN, seguirían ocupando en la capa anterior.
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*


# ----------------------------------------------------------------------------
# SHELL: qué intérprete usar en los siguientes RUN
# ----------------------------------------------------------------------------
# Por defecto Docker usa /bin/sh (un shell más limitado y antiguo). Lo
# cambiamos a bash por si agregamos más instrucciones con sintaxis
# moderna (arrays, [[ ]], etc.).
SHELL ["/bin/bash", "-c"]


# ----------------------------------------------------------------------------
# WORKDIR: directorio de trabajo al entrar al contenedor
# ----------------------------------------------------------------------------
# Codespaces siempre monta el código del repositorio en
# /workspaces/<nombre-del-repo>. Establecer /workspaces aquí hace que las
# terminales se abran cerca de nuestros archivos del curso.
WORKDIR /workspaces

# Configuración de Git para el contenedor:
# - safe.directory *: confía en cualquier repo montado (necesario porque
#   /workspaces/... tiene un UID distinto al de root dentro del container).
# - init.defaultBranch main: evita warnings de "master vs main" en git init.
# - pull.rebase false: merge por defecto al hacer pull (más intuitivo)
# - git lfs install --system: registra los hooks de LFS globalmente para
#   que, si un repo los necesita, funcionen sin sorpresas.
RUN git config --system --add safe.directory '*' \
 && git config --system init.defaultBranch main \
 && git config --system pull.rebase false \
 && git lfs install --system

# ----------------------------------------------------------------------------
# CMD: comando que se ejecuta por defecto al arrancar el contenedor
# ----------------------------------------------------------------------------
# Lanza una shell bash interactiva. Codespaces la sobrescribe con su
# propia terminal integrada de VS Code, pero es buena práctica dejarla
# definida para que la imagen sea usable también con Docker puro.
# Prompt del curso para bash
RUN chsh -s /usr/bin/zsh/ root

RUN cat>> /root/.zshrc <<'EOF'

PROMPT='%F{cyan}[Jose]%f %F{yellow}%1~%f %(?.%F{green}ok%f.%F{red}notok %?%f) %# '
EOF

CMD ["/usr/bin/zsh"]


