FS = {}

function FS.exists(path)
	local file = io.open(path, "r")
	if file then
		file:close()
		return true
	end
	return false
end

function FS.mkdir(path)
	if FS.exists(path) then
		return true
	end
	-- os.execute() runs this through /bin/sh -c, so path must be shell-quoted, not just
	-- wrapped in double quotes: a caller-controlled path (e.g. built from a player name,
	-- see player.lua's report handlers) containing a `"`, `` ` `` or `$` would otherwise
	-- break out of the quoting and inject arbitrary shell commands (SECURITY_AUDIT.md 3.1.3).
	-- Single-quoting is injection-proof for any content except a literal single quote, which
	-- is escaped with the standard '\'' trick (close quote, escaped literal quote, reopen).
	local quotedPath = "'" .. path:gsub("'", "'\\''") .. "'"
	local success, err = os.execute("mkdir " .. quotedPath)
	if not success then
		return false, err
	end
	return true
end

function FS.mkdir_p(path)
	if path == "" then
		return true
	end

	local components = {}
	for component in path:gmatch("[^/\\]+") do
		table.insert(components, component)
	end

	local currentPath = ""
	for i, component in ipairs(components) do
		currentPath = currentPath .. component

		if not FS.exists(currentPath) then
			local success, err = FS.mkdir(currentPath)
			if not success then
				return false, err
			end
		end

		if i < #components then
			currentPath = currentPath .. "/"
		end
	end

	return true
end
