FROM mcr.microsoft.com/devcontainers/base:jammy

# Basic tools & Flutter deps (lean set; good for web)
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      git curl unzip xz-utils zip ca-certificates \
      clang cmake ninja-build pkg-config libgtk-3-dev libglu1-mesa && \
    rm -rf /var/lib/apt/lists/*

# Install Flutter (stable) from source repo
RUN git clone https://github.com/flutter/flutter.git -b stable /usr/local/flutter

# Add Flutter & Dart to PATH
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Warm up a bit so first run is faster
RUN flutter --version
