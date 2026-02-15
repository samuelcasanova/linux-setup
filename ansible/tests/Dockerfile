FROM ubuntu:22.04

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Madrid
ENV LANG=C.UTF-8

# Preconfigure tzdata to avoid prompts
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install minimal dependencies (git needed to clone the repo in production)
RUN apt-get update && \
    apt-get install -y \
        python3 \
        sudo \
        systemd \
        systemd-sysv \
        git \
    && rm -rf /var/lib/apt/lists/*

# Create user 'samuel' matching the real system
RUN useradd -m -s /bin/bash samuel && \
    echo "samuel ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Create directory structure matching real system
RUN mkdir -p /home/samuel/git/setups

# Copy the install script from ansible directory
COPY --chown=samuel:samuel install-ansible.sh /tmp/install-ansible.sh
RUN chmod +x /tmp/install-ansible.sh

# Install Ansible using the same script as production
RUN /tmp/install-ansible.sh && rm /tmp/install-ansible.sh

# Switch to samuel user
USER samuel
WORKDIR /home/samuel

# Default command
CMD ["/bin/bash"]
