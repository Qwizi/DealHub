# DealHub
![PyPI - Python Version](https://img.shields.io/pypi/pyversions/Django)
[![Create Release](https://github.com/Qwizi/DealHub/actions/workflows/release.yml/badge.svg)](https://github.com/Qwizi/DealHub/actions/workflows/release.yml)
[![Publish Backend Docker image](https://github.com/Qwizi/DealHub/actions/workflows/docker.yml/badge.svg)](https://github.com/Qwizi/DealHub/actions/workflows/docker.yml)

DealHub is a a web application that allow users to post deals on products and services.

Build with
- Django
- DaisyUI
- HTMX
- Postgres
- Docker

## Live Demo
[DealHub](https://dealhub.qwizi.ovh/)

## Installation

- ### Linux
   #### Prerequisites
  - Docker
  - Curl

   ```bash
   curl -fsSL https://raw.githubusercontent.com/Qwizi/DealHub/master/scripts/install.sh | bash
   ```

- ### Windows (Powershell)
   #### Prerequisites
   - Docker Desktop

   ```powershell
   Invoke-Expression ((New-Object System.Net.WebClient).DownloadString("https://raw.githubusercontent.com/Qwizi/DealHub/master/scripts/install.ps1"))
   ```


## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing
purposes.

### Prerequisites

- Python 3.10 or higher
- Poetry
- Git
- Docker

### Installation

#### With pip

1. **Clone the repository**: This will create a copy of this project on your local machine.

    ```shell
    git clone https://github.com/Qwizi/DealHub
    ```

3. **Install dependencies**: Navigate into the cloned project's directory and install the necessary dependencies.

    ```shell
   cd DealHub
   python -m venv venv
    ```

4. **Activate the virtual environment**: This step ensures that the hooks are installed and
   active.

    ```shell
    venv/Scripts/Activate
    ```
5. **Install dependencies**
   ```shell
   pip install -r .\requirements.txt
   ```

6. **Copy .env.example to .env**
    ```shell
    mv .env.example .env
    ```
7. **Start docker desktop app**
8. **Run the application**: This will start the application on your local machine.

    ```shell
    ./scripts/run.ps1
    ```


#### With poetry

1. **Install Poetry**: [Poetry](https://python-poetry.org/docs/#installation) is a tool for dependency management and
   packaging in Python. You can use [pipx](https://pipx.pypa.io/stable/installation/) to install it globally, which is
   recommended.

    ```shell
    pipx install poetry
    ```

2. **Clone the repository**: This will create a copy of this project on your local machine.

    ```shell
    git clone https://github.com/Qwizi/DealHub
    ```

3. **Install dependencies**: Navigate into the cloned project's directory and install the necessary dependencies.

    ```shell
   cd DealHub
   poetry install
    ```

4. **Activate the virtual environment**: This step ensures that the hooks are installed and
   active.

    ```shell
    poetry shell
    ```
5. **Run the application**: This will start the application on your local machine.

    ```shell
    ./scripts/run.sh
    ```
### ShowCase
![image 1](https://i.imgur.com/hEeWnNu.png)
![image 2](https://i.imgur.com/kGsBR7j.png)
![image 3](https://i.imgur.com/tM1HFvB.png)

## Legal info
© Copyright by Adrian Ciołek (@Qwizi), Mateusz Cyran (@Kuis03), Kamil Duszyński (@VirdisPl), Dawid Dymek (@dawiddymek1108), Nikodem Decewicz (Szimurka).