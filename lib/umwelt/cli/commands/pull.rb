# frozen_string_literal: true

module Umwelt::CLI
  class Commands::Pull < Hanami::CLI::Command
    desc 'Pull project from remote Umwelt'

    def call(*)
      puts 'Pulling project'
    end
  end
end
