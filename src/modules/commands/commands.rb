module Bot::DiscordCommands
  module Commands
    extend Discordrb::Commands::CommandContainer
    command(:commands) do |event|
      help_text = 
      	<<~HEREDOC
      		The prefix is currently ! (changeable)
      		Commands:
      			start                 : starts new session
      			stop                  : end session
      			score <numeric score> : log a new score for the session
      			stats                 : show session stats
    	HEREDOC
  		event.respond help_text
      return
    end
  end
end