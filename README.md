# PythonSetup

The newpy project setup automates the initialization process for new Python projects via Bash, facilitating the creation of essential project structures and configurations. This script expedites the start of Python projects for developers.

## Table of Contents
  - [Overview](#overview)
  - [Installation](#installation)
    - [For Linux/Mac](#for-linuxmac)
  - [Usage](#usage)
  - [Features](#features)
  - [License](#license)

## Overview

- The newpy project setup program is a command-line tool designed to streamline the initialization process for new Python projects with Bash. This script automates the creation of essential project structures and configurations, enabling developers to kickstart their Python projects efficiently.

## Installation

### For Linux/Mac :

1. Clone the repository:
    ```bash
    git clone https://github.com/SPET-PV/newpy.git
    ```
2. Navigate to the `newpy` directory and grant executable permissions to `newpy.sh`:
    ```bash
    cd newpy
    chmod +x "newpy.sh"
    ```
3. Copy `newpy.sh` to your project folder:
    ```bash
    mv newpy.sh your_folder/newpy.sh
    cd your_folder
    ```

## Usage

1. Execute `newpy.sh` in your terminal, providing your SSH or HTTPS repository link as an argument to initiate the setup process:
    ```bash
    ./newpy.sh Your_Repository_Link
    ```
2. Follow the prompts to configure your project settings.
3. Enjoy the streamlined setup for your Python projects.

## Features

1. **Git Initialization:** Automates the setup of a Git repository, including remote origin configuration.
2. **Project Directory Structure:** Generates `main.py`, a core package with basic configuration, and updates `README.md` and `.gitignore` files.
3. **Virtual Environment Creation:** Optionally creates a virtual environment for the project, allowing for basic packages [flake8](https://pypi.org/project/flake8/), [Sphinx](https://pypi.org/project/Sphinx/), and [pytest](https://pypi.org/project/pytest/).
4. **GitHub CI Integration:** Assists in setting up basic GitHub Continuous Integration (CI) for linting and testing with Python [3.11.2](https://www.python.org/downloads/release/python-3112/).

## License

- This project is licensed under the [MIT License](https://opensource.org/licenses/MIT) - refer to the [LICENSE](LICENSE) file for details.
