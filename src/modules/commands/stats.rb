module Bot::DiscordCommands
  module Stats
    extend Discordrb::Commands::CommandContainer
    command(:stats) do |event|
      session = Bot::Sessions[event.server.id]
  		event.respond session.stats
      return
    end
  end
end