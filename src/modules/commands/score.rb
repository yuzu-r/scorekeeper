module Bot::DiscordCommands
  module UpdateScore
    extend Discordrb::Commands::CommandContainer
    command(:sr, min_args: 1, usage: 'sr <number>') do |event, score|
    	# to-do: add validation for score
    	#invalid_score = /\D/ === score
    	#if invalid_score
    	#	event.respond "Enter only digits for the score."
    #		return
    #	end
      session = Bot::Sessions[event.server.id][event.channel.id]
      if session.start_time.nil?
      	event.respond "Starting session..."
      	session.start_session
      end
      event.respond session.update_score(score)
      return
    end
  end
end