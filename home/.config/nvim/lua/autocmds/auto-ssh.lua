local function log(msg)
	vim.schedule(function()
		vim.notify(msg, vim.log.levels.INFO, { title = "repo-ssh" })
	end)
end
local function setup_repo_ssh()
	-- 1. Directory we just moved to
	local cwd = vim.v.event.cwd or vim.loop.cwd()

	-- 2. Fire off non-blocking Git query
	vim.system({ "git", "-C", cwd, "rev-parse", "--show-toplevel" }, { text = true }, function(obj)
		if obj.code ~= 0 then
			return
		end -- not a repo -> ignore
		local git_root = obj.stdout:gsub("%s+$", "")

		-- 3. Check for .ssh/ + keys
		local ssh_dir = git_root .. "/.ssh"
		vim.system(
			{ "find", ssh_dir, "-maxdepth", "1", "-type", "f", "-name", "id_*pub" },
			{ text = true },
			function(ls_obj)
				if ls_obj.code ~= 0 or ls_obj.stdout == "" then
					log("No ssh keys found in " .. git_root)
					return
				end -- no key -> log
				local pub_path = ls_obj.stdout:match("[^\n]+")
				local priv_path = pub_path:gsub("%.pub$", "")
				log("Found ssh key " .. pub_path)

				-- 4. Configure repo-local SSH command
				vim.system({
					"git",
					"config",
					"--file",
					git_root .. "/.git/config",
					"core.sshCommand",
					("ssh -i %s -o IdentitiesOnly=yes"):format(priv_path),
				}, { text = true }, function(cfg_obj)
					if cfg_obj.code == 0 then
						log("SSH key configured: " .. priv_path)
					else
						log("Failed to set SSH key: " .. cfg_obj.stdeer)
					end
				end)
			end
		)
	end)
end

-- Run once on startup
setup_repo_ssh()

-- And every time Neovim changes directory
vim.api.nvim_create_autocmd("DirChanged", {
	pattern = "global",
	callback = setup_repo_ssh,
})
