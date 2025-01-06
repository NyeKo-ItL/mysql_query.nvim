# mysql_query.nvim

A simple Neovim plugin to execute MySQL queries using the contents of a file and display results in a popup.

## Prerequisites

1. Install the MySQL CLI

The MySQL CLI is a part of the MySQL client utilities. Follow the steps below to install it.

On macOS:
• Install MySQL using Homebrew:
```bash
brew install mysql
```

Check the installation
```bash
mysql --version
```

On Linux:
• Install MySQL client tools using your package manager:
```bash
sudo apt-get install mysql-client # For Debian/Ubuntu
sudo yum install mysql # For CentOS/RHEL
```

Check the installation
```bash
mysql --version
```

On Windows:
• Download and install the MySQL installer from the official website: [MySQL Installer](https://dev.mysql.com/downloads/installer/)
• During installation, ensure the MySQL Shell or MySQL CLI is selected.
• Add the MySQL CLI to your system’s PATH variable (usually in C:\Program Files\MySQL\MySQL Server <version>\bin).

## Installation

Using `lazy.nvim`:
```lua
return {
{
"NyeKo-ItL/mysql_query.nvim", -- Replace 'your-username' with your GitHub username
config = function()
require("mysql_query").setup()
end,
}
}
```

## Usage
```lua
:SetMySQLConfig <user> <password> <host> <database>
```

Open a '.sql' file in Neovim and run the command:
```lua
:RunMySQLQuery
```