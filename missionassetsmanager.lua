if not SystemMessages then dofile(ModPath .. "loc.lua") end

if string.lower(RequiredScript) == "lib/managers/missionassetsmanager" then
	function MissionAssetsManager:_feed_unlock_message(asset_id)
		local asset_tweak_data = tweak_data.assets[asset_id]
		local session = managers.network:session()
		if not (managers.chat and session and asset_tweak_data and asset_tweak_data.name_id) then
			return
		end
		local asset = managers.localization:text(asset_tweak_data.name_id)
		local text
		if self.ALLOW_CLIENTS_UNLOCK then
			text = SystemMessages.text("menu_chat_unlocked_asset", {asset = asset})
		else
			local peer = Network:is_server() and session:local_peer() or session:server_peer() or session:local_peer()
			text = SystemMessages.text("menu_chat_peer_unlocked_asset", {name = peer:name(), asset = asset})
		end
		managers.chat:feed_system_message(ChatManager.GAME, text)
	end

	Hooks:PreHook(MissionAssetsManager, "sync_unlock_asset", "asset_bought_message", function(self, asset_id)
		local asset = self:_get_asset_by_id(asset_id)
		if asset and not asset.unlocked then
			self:_feed_unlock_message(asset_id)
		end
	end)
end