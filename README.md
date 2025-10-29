# Code Along NTT

Development environment setup for Ubuntu with UK English locale, supporting Node.js, TypeScript, Python, and .NET 9.

## Quick Start

### Automated Setup
Run the setup script to automatically configure your development environment:

```bash
./setup-dev-environment.sh
```

### Manual Setup
If you prefer to set up manually or need to customize the installation:

#### Prerequisites
- Ubuntu 20.04+ (tested on Ubuntu 22.04)
- Internet connection for package downloads

#### Step-by-Step Installation

1. **Update system and install dependencies:**
   ```bash
   sudo apt-get update
   sudo apt-get install -y locales curl wget git build-essential software-properties-common
   ```

2. **Configure UK English locale:**
   ```bash
   sudo locale-gen en_GB.UTF-8
   sudo update-locale LANG=en_GB.UTF-8
   export LANG=en_GB.UTF-8
   ```

3. **Install Node.js 20 LTS:**
   ```bash
   curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
   sudo apt-get install -y nodejs
   ```

4. **Install Python 3.11:**
   ```bash
   sudo add-apt-repository ppa:deadsnakes/ppa -y
   sudo apt-get update
   sudo apt-get install -y python3.11 python3.11-pip python3.11-dev python3.11-venv
   ```

5. **Install .NET 9:**
   ```bash
   wget https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb
   sudo dpkg -i packages-microsoft-prod.deb
   sudo apt-get update
   sudo apt-get install -y dotnet-sdk-9.0
   ```

6. **Install project dependencies:**
   ```bash
   # Node.js dependencies
   npm install
   
   # Python dependencies
   python3.11 -m pip install --user -r requirements.txt
   
   # .NET dependencies
   dotnet restore
   ```

## Development

### TypeScript/Node.js
```bash
# Build TypeScript
npm run build

# Run in development mode
npm run dev

# Run compiled JavaScript
npm start

# Run tests
npm test

# Lint code
npm run lint
npm run lint:fix
```

### Python
```bash
# Run the main application
python3.11 src/main.py

# Run tests
pytest tests/

# Format code
black src/ tests/

# Lint code
flake8 src/ tests/

# Type checking
mypy src/
```

### .NET
```bash
# Run the application
dotnet run

# Build the project
dotnet build

# Run tests (when test projects are added)
dotnet test

# Publish for production
dotnet publish -c Release
```

## Project Structure

```
├── src/                    # Source code
│   ├── index.ts           # TypeScript main file
│   ├── main.py            # Python main file
│   └── ...
├── tests/                 # Test files
│   ├── index.test.ts      # TypeScript tests
│   ├── test_main.py       # Python tests
│   └── ...
├── dist/                  # Compiled TypeScript output
├── bin/obj/              # .NET build artifacts
├── Program.cs            # .NET main file
├── CodeAlongNtt.csproj   # .NET project file
├── package.json          # Node.js dependencies
├── tsconfig.json         # TypeScript configuration
├── requirements.txt      # Python dependencies
├── pyproject.toml        # Python project configuration
├── global.json           # .NET SDK version
├── locale.conf           # UK English locale settings
├── Dockerfile            # Container setup
├── .eslintrc.json        # ESLint configuration
├── .gitignore           # Git ignore rules
└── setup-dev-environment.sh  # Automated setup script
```

## Configuration Details

### Locale Settings
The environment is configured for UK English (`en_GB.UTF-8`) with:
- Date format: DD/MM/YYYY
- Time format: 24-hour (HH:MM)
- Currency: GBP (£)
- Measurement: Metric system

### Technology Versions
- **Node.js:** 20.x LTS
- **TypeScript:** ^5.0.0
- **Python:** 3.11+
- **.NET:** 9.0

### Code Quality Tools
- **TypeScript:** ESLint with TypeScript rules
- **Python:** Black (formatting), Flake8 (linting), MyPy (type checking)
- **.NET:** Built-in analyzers with TreatWarningsAsErrors

## Docker Usage

Build and run the development environment in a container:

```bash
# Build the Docker image
docker build -t code-along-ntt .

# Run the container
docker run -it --rm -v $(pwd):/workspace code-along-ntt

# Or run with port forwarding for web applications
docker run -it --rm -p 3000:3000 -v $(pwd):/workspace code-along-ntt
```

## Sample Applications

Each technology includes a sample application demonstrating UK locale formatting:

- **TypeScript:** `src/index.ts` - UK date/time formatting with proper typing
- **Python:** `src/main.py` - UK locale handling with datetime formatting  
- **.NET:** `Program.cs` - UK culture formatting with dependency injection

All samples output UK-formatted dates (DD/MM/YYYY) and 24-hour time format.

## Troubleshooting

### Locale Issues
If you encounter locale-related errors:
```bash
sudo dpkg-reconfigure locales
# Select en_GB.UTF-8 from the list
```

### Permission Issues
If you get permission errors with npm:
```bash
npm config set prefix ~/.local
echo 'export PATH=~/.local/bin:$PATH' >> ~/.bashrc
source ~/.bashrc
```

### .NET SSL Issues
If you encounter SSL certificate issues:
```bash
dotnet dev-certs https --trust
```

## Contributing

1. Ensure all technologies are properly configured
2. Run tests for all modified components
3. Follow the established code style for each language
4. Update documentation as needed

## License

ISC