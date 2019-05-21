# Gems
require 'discordrb'
require 'bundler/setup'
require_relative 'classes/session'
require 'chronic'
require 'tzinfo'

# The main bot module.
module Bot
  # Bot configuration
  client_id = ENV['DISCORD_CLIENT_ID']
  token = ENV['DISCORD_TOKEN']
  MAX_MESSAGE_LENGTH = 2000
  PREFIX = ENV['DISCORD_PREFIX']
  Sessions = Hash.new

  # Load non-Discordrb modules
  Dir['src/modules/*.rb'].each { |mod| load mod }

  # This structure is adapted from Gemstone: https://github.com/z64/gemstone
  # Create the bot.
  # The bot is created as a constant, so that you
  # can access the cache anywhere.
  BOT = Discordrb::Commands::CommandBot.new(client_id: client_id,
                                            token: token,
                                            prefix: PREFIX)

  # This class method wraps the module lazy-loading process of discordrb command
  # and event modules. Any module name passed to this method will have its child
  # constants iterated over and passed to `Discordrb::Commands::CommandBot#include!`
  # Any module name passed to this method *must*:
  #   - extend Discordrb::EventContainer
  #   - extend Discordrb::Commands::CommandContainer
  # @param klass [Symbol, #to_sym] the name of the module
  # @param path [String] the path underneath `src/modules/` to load files from

  def self.load_modules(klass,path)
    new_module = Module.new
    const_set(klass.to_sym, new_module)
    Dir["modules/#{path}/*.rb"].each { |file| load file }
    new_module.constants.each do |mod|
      BOT.include! new_module.const_get(mod)
    end
  end

  load_modules(:DiscordEvents, 'events')
  load_modules(:DiscordCommands, 'commands')

  # Run the bot
  BOT.run
end