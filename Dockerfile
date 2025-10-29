# Ubuntu-based development environment
FROM ubuntu:22.04

# Set UK English locale
ENV LANG=en_GB.UTF-8
ENV LANGUAGE=en_GB:en
ENV LC_ALL=en_GB.UTF-8

# Install system dependencies
RUN apt-get update && apt-get install -y \
    locales \
    curl \
    wget \
    git \
    build-essential \
    software-properties-common \
    ca-certificates \
    gnupg \
    lsb-release \
    && rm -rf /var/lib/apt/lists/*

# Configure UK English locale
RUN locale-gen en_GB.UTF-8 && \
    update-locale LANG=en_GB.UTF-8

# Install Node.js 20 LTS
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs

# Install Python 3.11
RUN add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && \
    apt-get install -y python3.11 python3.11-pip python3.11-dev python3.11-venv

# Install .NET 9
RUN wget https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb && \
    dpkg -i packages-microsoft-prod.deb && \
    rm packages-microsoft-prod.deb && \
    apt-get update && \
    apt-get install -y dotnet-sdk-9.0

# Set working directory
WORKDIR /workspace

# Copy package files
COPY package*.json tsconfig.json ./
COPY requirements.txt pyproject.toml ./
COPY global.json *.csproj ./

# Install dependencies
RUN npm install
RUN python3.11 -m pip install -r requirements.txt
RUN dotnet restore

CMD ["/bin/bash"]