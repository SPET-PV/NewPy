#!/bin/bash

new_py() {
  # Git Setup
  ## Check if an argument is provided or not
  if [ -z "$1" ]; then
    echo "Usage: $0 <SSH_REPO_LINK>"
    echo "Please provide the SSH repository link."
    read -r ssh_repo_link
  else
    ssh_repo_link="$1"
  fi
  ## Init Check
  if [ -d ".git" ]; then
    echo "A '.git' folder already exists."
  else 
    git init || { echo "Failed to initialize Git repository. Exiting."; exit 1; }
  fi
  ## Connection Check
  connected=false
  while [ "$connected" != true ]; do
    git remote add origin "$ssh_repo_link" || { echo "Failed to connect to the Git repository."; }
    if [ -z "$(git remote get-url origin)" ]; then
      echo "Invalid repository link. Please provide a correct SSH repository link."
      read -r ssh_repo_link
    else
      connected=true
    fi
  done
  git pull origin master && git branch --set-upstream-to=origin/master master
  echo    "┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓"
  echo    "┃        GitHub Repository Setup Completed         ┃"
  echo -e "┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛ \n"
  
  # Python Environement (venv) Initialisation Part
  echo "Would you like to set up a personal virtual environment for this project? (y/n)"
  read -r choice
  if [[ "${choice,,}" == "y" || "${choice,,}" == "yes" || -z "$choice" ]]; then
    echo "Preparing the 'venv' virtual environment..."
    python3 -m venv project_env
    source project_env/bin/activate
    ## Basic Packages installation
    echo "Would you like to install these basic packages (flake8, pytest, Sphinx)? (y/n)"
    read -r install
    if [[ "${install,,}" == "y" || "${install,,}" == "yes" || -z "$install" ]]; then
      pip install flake8 Sphinx pytest
    else
      echo "Proceeding without any package installation..."
    fi
    echo    "┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓"
    echo    "┃       Virtual Environment Setup Completed        ┃"
    echo -e "┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛ \n"
  else
    echo "Proceeding without setting up a virtual environment..."
  fi
  
  # Directories and file creation
  echo "Would you like to set up a basic GitHub CI (Lint and Test) for this project? (y/n)"
  read -r choice2
  if [[ "${choice2,,}" == "y" || "${choice2,,}" == "yes" || -z "$choice" ]]; then
    mkdir -p .github/workflows
    cat <<EOF > .github/workflows/pythonCI.yml
name: Python CI

on:
  push:
    branches:
      - master
  pull_request:
    branches:
      - master

jobs:
  lint:
    name: Lint with flake8
    runs-on: ubuntu-latest
    
    steps:
    - name: Checkout repository
      uses: actions/checkout@v2
      
    - name: Set up Python
      uses: actions/setup-python@v2
      with:
        python-version: 3.11.2
      
    - name: Install dependencies
      run: |
        python -m pip install --upgrade pip
        pip install flake8
        
    - name: Run flake8
      run: "flake8 \\
        --format='::error file=%(path)s,line=%(row)d,col=%(col)d::\\
        [flake8] %(code)s: %(text)s'"

  test:
    name: Test with pytest
    runs-on: ubuntu-latest
    
    steps:
    - name: Checkout repository
      uses: actions/checkout@v2
      
    - name: Set up Python
      uses: actions/setup-python@v2
      with:
        python-version: 3.11.2
      
    - name: Install dependencies
      run: |
        python -m pip install --upgrade pip
        pip install -r requirements.txt
        
    - name: Run tests
      run: |
        pytest
EOF
    echo    "┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓"
    echo    "┃            Github CI Setup Completed             ┃"
    echo -e "┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛ \n"
  else
    echo "Proceeding without setting up a GitHub CI..."
  fi
  echo "Creating necessary directories and files..."
  ## Modules and project setup
  mkdir -p core/
  touch requirements.txt main.py core/base_template.py core/__init__.py
  ## Creating readme and gitignore if they don't exist
  readme="README.md"
  gitignore=".gitignore"
  touch "$readme" "$gitignore"
  ## Filling the files 
  echo -e "from .base_template import *\n\n__all__ = (base_template)" >> core/__init__.py
  echo -e "from core import *\n\nif __name__ == "__main__":\n\tpass" >> main.py
  echo -e "project_env/" >> ".gitignore"
  cat <<EOF >> README.md

## Table of Contents
- [Overview](#overview)
- [Installation](#installation)
- [Usage](#usage)
- [Features](#features)
- [Contributing](#contributing)
- [License](#license)

## Overview


## Installation


## Usage


## Features


## Contributing


## License

EOF
  echo "Would you like to push this setup to GitHub? (y/n)"
  read -r choice3
  if [[ "${choice3,,}" == "y" || "${choice3,,}" == "yes" || -z "$choice3" ]]; then
    git add .
    git commit -m "Initial Setup"
    git push
  else
    echo -e "Continuing without pushing this setup to your GitHub repository... \n"
  fi
  echo    "┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓"
  echo    "┃        Setup for Your New Python Project Completed      ┃"
  echo -e "┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛ \n"
}

new_py "$1"


