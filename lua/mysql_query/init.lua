local mysql_query = {}

_G.mysql_config = {
	user = "user",
	password = "root",
	host = "127.0.0.1",
	database = "db",
}

local function execute_query(file_path)
	file_path = file_path:gsub("\\", "/")
	local uri = string.format(
		"mysql://%s:%s@%s/%s",
		_G.mysql_config.user,
		_G.mysql_config.password,
		_G.mysql_config.host,
		_G.mysql_config.database
	)

	local command = string.format(
		"mysqlsh --sql --uri='%s' --file=%s",
		uri,
		file_path
	)

	local handle = io.popen(command .. " 2>&1")
	local result = handle:read("*a")
	handle:close()
	return result
end


local function display_popup(content)
	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(content, "\n"))

	local width = math.ceil(vim.o.columns * 0.8)
	local height = math.ceil(vim.o.lines * 0.8)

	local win_opts = {
		relative = 'editor',
		width = width,
		height = height,
		row = math.ceil((vim.o.lines - height) / 2),
		col = math.ceil((vim.o.columns - width) / 2),
		style = 'minimal',
		border = 'rounded',
	}

	vim.api.nvim_open_win(buf, true, win_opts)
end

function mysql_query.run_mysql_query()
	local file_path = vim.fn.expand("%:p")
	if file_path == "" or not vim.fn.filereadable(file_path) then
		vim.notify("Fichier invalide ou introuvable.", vim.log.levels.ERROR)
		return
	end

	local result = execute_query(file_path)
	if result == "" then
		vim.notify("La requête n'a retourné aucun résultat.", vim.log.levels.INFO)
	else
		display_popup(result)
	end
end

function mysql_query.setup()
	vim.api.nvim_create_user_command(
		'SetMySQLConfig',
		function(opts)
			local args = vim.split(opts.args, " ")
			if #args < 4 then
				vim.notify(
					"Utilisation : :SetMySQLConfig <utilisateur> <motdepasse> <hôte> <base_de_données>",
					vim.log.levels.ERROR
				)
				return
			end

			_G.mysql_config.user = args[1]
			_G.mysql_config.password = args[2]
			_G.mysql_config.host = args[3]
			_G.mysql_config.database = args[4]

			vim.notify("Configuration MySQL mise à jour.", vim.log.levels.INFO)
		end,
		{ nargs = 1 }
	)

	vim.api.nvim_create_user_command(
		'RunMySQLQuery',
		mysql_query.run_mysql_query,
		{ nargs = 0 }
	)
end

return mysql_query
