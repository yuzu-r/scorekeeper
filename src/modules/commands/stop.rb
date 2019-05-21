module Bot::DiscordCommands
  module StopSession
    extend Discordrb::Commands::CommandContainer
    command(:stop) do |event|
      event.respond "Stopping session..."
      session = Bot::Sessions[event.server.id]
      event.respond session.stats
      session.stop_session
      return
    end
  end
end