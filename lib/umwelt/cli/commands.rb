# frozen_string_literal: true

module Umwelt::CLI::Commands
  require_relative './commands/convey'
  require_relative './commands/clone'
  require_relative './commands/example'
  require_relative './commands/pull'
  require_relative './commands/version'

  extend Hanami::CLI::Registry

  register 'convey', Convey
  register 'clone', Clone
  register 'example', Example
  register 'pull', Pull
  register 'version', Version
end
