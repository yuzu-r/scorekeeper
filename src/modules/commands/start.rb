module Bot::DiscordCommands
  module StartSession
    extend Discordrb::Commands::CommandContainer
    command(:start) do |event|
      event.respond "Starting session..."
      session = Bot::Sessions[event.server.id][event.channel.id]
      session.start_session
      event.respond "New session tracking has begun."
      return
    end
  end
end