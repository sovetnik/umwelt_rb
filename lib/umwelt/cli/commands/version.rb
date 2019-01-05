# frozen_string_literal: true

module Umwelt::CLI::Commands
  class Version < Hanami::CLI::Command
    def call(*)
      puts Umwelt::VERSION
    end
  end
end
