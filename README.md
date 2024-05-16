# DealHub

DealHub is a a web application that allow users to post deals on products and services.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing
purposes.

### Prerequisites

- Python 3.11 or higher
- Poetry
- Git
- Docker

### Installation

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

## Installation

- ### Linux
   ### Prerequisites
  - Docker
  - Curl

   ```bash
   curl -fsSL https://raw.githubusercontent.com/Qwizi/DealHub/master/scripts/install.sh | bash
   ```

- ### Windows (Powershell)

```powershell
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString("https://raw.githubusercontent.com/Qwizi/DealHub/master/scripts/install.ps1"))
```
