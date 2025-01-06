# mysql_query.nvim

A simple Neovim plugin to execute MySQL queries using the contents of a file and display results in a popup.

## Installation

Using `lazy.nvim`:

```lua
{
    "NyeKo-ItL/mysql_query.nvim",
    config = function()
        require("mysql_query").setup()
    end,
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

