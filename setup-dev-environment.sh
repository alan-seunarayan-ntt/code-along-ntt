#!/bin/bash

# Development Environment Setup Script
# Supports Ubuntu with UK English, Node.js, TypeScript, Python, and .NET 9

set -e

echo "Setting up development environment for Ubuntu with UK English locale..."

# Check if running on Ubuntu
if ! grep -q "ubuntu" /etc/os-release; then
    echo "Warning: This script is designed for Ubuntu. Some commands may not work on other distributions."
fi

# Update package list
echo "Updating package list..."
sudo apt-get update

# Install system dependencies
echo "Installing system dependencies..."
sudo apt-get install -y \
    locales \
    curl \
    wget \
    git \
    build-essential \
    software-properties-common \
    ca-certificates \
    gnupg \
    lsb-release

# Set up UK English locale
echo "Configuring UK English locale..."
sudo locale-gen en_GB.UTF-8
sudo update-locale LANG=en_GB.UTF-8
export LANG=en_GB.UTF-8
export LC_ALL=en_GB.UTF-8

# Install Node.js 20 LTS if not already installed
if ! command -v node &> /dev/null; then
    echo "Installing Node.js 20 LTS..."
    curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
    sudo apt-get install -y nodejs
else
    echo "Node.js already installed: $(node --version)"
fi

# Install Python 3.11 if not already available
if ! command -v python3.11 &> /dev/null; then
    echo "Installing Python 3.11..."
    sudo add-apt-repository ppa:deadsnakes/ppa -y
    sudo apt-get update
    sudo apt-get install -y python3.11 python3.11-pip python3.11-dev python3.11-venv
else
    echo "Python 3.11 already installed: $(python3.11 --version)"
fi

# Install .NET 9 if not already installed
if ! command -v dotnet &> /dev/null || ! dotnet --version | grep -q "9."; then
    echo "Installing .NET 9..."
    wget https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
    sudo dpkg -i packages-microsoft-prod.deb
    rm packages-microsoft-prod.deb
    sudo apt-get update
    sudo apt-get install -y dotnet-sdk-9.0
else
    echo ".NET 9 already installed: $(dotnet --version)"
fi

# Install Node.js dependencies
if [ -f "package.json" ]; then
    echo "Installing Node.js dependencies..."
    npm install
fi

# Install Python dependencies
if [ -f "requirements.txt" ]; then
    echo "Installing Python dependencies..."
    python3.11 -m pip install --user -r requirements.txt
fi

# Restore .NET dependencies
if [ -f "*.csproj" ] || [ -f "global.json" ]; then
    echo "Restoring .NET dependencies..."
    dotnet restore
fi

# Create sample source directories
echo "Creating sample source directories..."
mkdir -p src tests

echo "Development environment setup complete!"
echo ""
echo "Installed versions:"
echo "- Node.js: $(node --version)"
echo "- npm: $(npm --version)"
echo "- TypeScript: $(npx tsc --version 2>/dev/null || echo 'Not installed globally')"
echo "- Python: $(python3.11 --version)"
echo "- .NET: $(dotnet --version)"
echo ""
echo "Locale: $(locale | grep LANG)"
echo ""
echo "Next steps:"
echo "1. Run 'source ~/.bashrc' or restart your terminal to apply locale changes"
echo "2. Create your source files in the 'src' directory"
echo "3. Add tests to the 'tests' directory"
echo "4. Use npm run scripts for TypeScript development"
echo "5. Use dotnet commands for .NET development"
echo "6. Use python3.11 for Python development"