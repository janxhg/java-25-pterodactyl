FROM eclipse-temurin:25-jdk-jammy

LABEL maintainer="TurboMC"
LABEL description="Java 25 Docker image for Pterodactyl - Ready for Hytale"
LABEL version="1.0.0"

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    fontconfig \
    ca-certificates \
    tzdata \
    iproute2 \
    && rm -rf /var/lib/apt/lists/*

# Create user for running the server
RUN useradd -m -d /home/container -s /bin/bash container

# Set working directory
WORKDIR /home/container

# Copy entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Switch to container user
USER container

# Set environment variables
ENV USER=container
ENV HOME=/home/container

# Expose default Minecraft port (can be overridden by Pterodactyl)
EXPOSE 25565

# Set entrypoint
ENTRYPOINT ["/entrypoint.sh"]
