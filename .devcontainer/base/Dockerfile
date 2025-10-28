# Base UBI9 image with general-purpose tools only
FROM registry.access.redhat.com/ubi9/ubi:latest

# Install basic tools that are commonly needed across all projects
RUN dnf update -y && \
    dnf install -y \
    git \
    curl \
    wget \
    vim \
    tar \
    gzip \
    unzip \
    jq \
    ca-certificates \
    && dnf clean all

# Create a non-root user for development
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && dnf install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME \
    && dnf clean all

USER $USERNAME
