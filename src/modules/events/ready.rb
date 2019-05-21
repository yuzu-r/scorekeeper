module Bot::DiscordEvents
  # This event is processed each time the bot succesfully connects to discord.
  module Ready
    extend Discordrb::EventContainer
    ready do |_event|
    	_event.bot.servers.each do |server_id, server|
    		Bot::Sessions[server_id] = Session.new
    	end
		end
  end
end
