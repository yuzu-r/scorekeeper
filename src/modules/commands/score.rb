module Bot::DiscordCommands
  module UpdateScore
    extend Discordrb::Commands::CommandContainer
    command(:score, min_args: 1, usage: 'score <number>') do |event, score|
    	# to-do: add validation for score
      session = Bot::Sessions[event.server.id]
      if session.start_time.nil?
      	event.respond "Starting session..."
      	session.start_session
      end
      event.respond "Updating score with #{score}..."
      session.update_score(score)
      return
    end
  end
end