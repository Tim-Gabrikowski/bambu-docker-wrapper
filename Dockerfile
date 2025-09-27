FROM ubuntu:22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive \
    APPIMAGE_FILE=BambuStudio.AppImage

# Install dependencies for AppImage (needed for GUI app, even in CLI mode)
RUN apt-get update && apt-get install -y \
    wget \
    fuse libfuse2 \
    libglib2.0-0 \
    libsm6 \
    libxrender1 \
    libxext6 \
    libfontconfig1 \
    ffmpeg \
    libgl1-mesa-glx \
    libgtk-3-0 \
    libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev \
    libwebkit2gtk-4.0-37 libjavascriptcoregtk-4.0-18 \
    && rm -rf /var/lib/apt/lists/*
    
# Download Bambu Studio AppImage (replace with a specific version)
RUN wget -O /opt/${APPIMAGE_FILE} https://github.com/bambulab/BambuStudio/releases/download/v02.02.02.56/Bambu_Studio_ubuntu-22.04_PR-8184.AppImage \
    && chmod +x /opt/${APPIMAGE_FILE}

# Extract AppImage so we don't rely on FUSE
RUN cd /opt && /opt/${APPIMAGE_FILE} --appimage-extract \
    && mv /opt/squashfs-root /opt/bambu-studio \
    && rm /opt/${APPIMAGE_FILE}

# Expose a workdir for slicing
WORKDIR /data

# Entrypoint wrapper to call AppImage
ENTRYPOINT ["/opt/bambu-studio/AppRun"]
