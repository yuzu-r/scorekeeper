module Bot::DiscordEvents
  # This event is processed each time the bot succesfully connects to discord.
  module Ready
    extend Discordrb::EventContainer
    ready do |_event|
    	_event.bot.servers.each do |server_id, server|
    		bot_profile = _event.bot.profile.on(server)
    		Bot::Sessions[server_id] = Hash.new
    	  server.channels.each do |channel|
    	  	can_send_messages = bot_profile.permission?(:send_messages, channel)
    	  	if can_send_messages
    	  		Bot::Sessions[server_id][channel.id] = Session.new	
    	  	end
    	  end
    	end
		end
  end
end
