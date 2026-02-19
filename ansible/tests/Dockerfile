FROM ubuntu:24.04

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Madrid
ENV LANG=C.UTF-8

# Preconfigure tzdata to avoid prompts
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install minimal dependencies
RUN apt-get update && \
    apt-get install -y \
        python3 \
        sudo \
        systemd \
        systemd-sysv \
        curl \
        wget \
        stow \
        unzip \
        ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Create user 'samuel' matching the real system
RUN useradd -m -s /bin/bash samuel && \
    echo "samuel ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Create directory structure matching real system
RUN mkdir -p /home/samuel/git/setups

# Copy the initialization script from ansible directory
COPY --chown=samuel:samuel init.sh /tmp/init.sh
RUN chmod +x /tmp/init.sh

# Initialize system using the same script as production
RUN /tmp/init.sh && rm /tmp/init.sh

# Switch to samuel user
USER samuel
WORKDIR /home/samuel

COPY --chown=samuel:samuel files/linux-setup-private /home/samuel/git/setups/linux-setup-private

# Default command
CMD ["/bin/bash"]
