if not SystemMessages then dofile(ModPath .. "loc.lua") end

Hooks:PostHook(NetworkGame, "on_peer_added", "peer_chat_messages_on_peer_added", function(self, peer, peer_id)
	if managers.chat then
		managers.chat:feed_system_message(ChatManager.GAME, SystemMessages.text("menu_chat_peer_added", {name = peer:name()}))
	end
end)

Hooks:PreHook(NetworkGame, "on_peer_removed", "peer_chat_messages_on_peer_removed", function(self, peer, peer_id, reason)
	if managers.chat and self._members[peer_id] then
		local id = reason == "left" and "menu_chat_peer_left"
			or reason == "kicked" and "menu_chat_peer_kicked"
			or "menu_chat_peer_lost"
		managers.chat:feed_system_message(ChatManager.GAME, SystemMessages.text(id, {name = peer:name()}))
	end
end)