Hooks:PostHook(NetworkGame, "on_peer_added", "peer_chat_messages_on_peer_added", function(self, peer, peer_id)
	if managers.chat then
		managers.chat:feed_system_message(ChatManager.GAME, peer:name() .. " is joining.")
	end
end)

Hooks:PreHook(NetworkGame, "on_peer_removed", "peer_chat_messages_on_peer_removed", function(self, peer, peer_id, reason)
	if managers.chat and self._members[peer_id] then
		local name = peer:name()
		local text
		if reason == "left" then
			text = name .. " left."
		elseif reason == "kicked" then
			text = name .. " has been kicked."
		else
			text = name .. "has been lost."
		end
		managers.chat:feed_system_message(ChatManager.GAME, text)
	end
end)