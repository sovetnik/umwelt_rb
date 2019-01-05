# frozen_string_literal: true

module Umwelt::CLI::Commands
  require_relative './commands/build'
  require_relative './commands/clone'
  require_relative './commands/pull'
  require_relative './commands/version'

  extend Hanami::CLI::Registry
  register 'build', Build
  register 'clone', Clone
  register 'pull', Pull

  register 'version', Version
end
