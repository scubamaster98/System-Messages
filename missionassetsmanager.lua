if string.lower(RequiredScript) == "lib/managers/missionassetsmanager" then
	function MissionAssetsManager:_feed_unlock_message(asset_id)
		local asset_tweak_data = tweak_data.assets[asset_id]
		local session = managers.network:session()
		if not (managers.chat and session and asset_tweak_data and asset_tweak_data.name_id) then
			return
		end
		local text = managers.localization:text(asset_tweak_data.name_id)
		if self.ALLOW_CLIENTS_UNLOCK then
			text = "Unlocked asset: " .. text --experimental
		else
			local peer = Network:is_server() and session:local_peer() or session:server_peer() or session:local_peer()
			text = peer:name() .. " unlocked asset: " .. text .. "."
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