SystemMessages = { path = ModPath, loaded = false }

function SystemMessages.text(id, macros)
	local loc = managers.localization
	if not SystemMessages.loaded then
		SystemMessages.loaded = true
		loc:load_localization_file(SystemMessages.path .. "loc/english.txt")
		local lang = SystemInfo:language():key()
		for _, filename in ipairs(file.GetFiles(SystemMessages.path .. "loc/")) do
			local name = filename:match("^(.*)%.txt$")
			if name and Idstring(name):key() == lang then
				loc:load_localization_file(SystemMessages.path .. "loc/" .. filename)
				break
			end
		end
	end
	return loc:text(id, macros)
end