# frozen_string_literal: true

module Umwelt::CLI
  class Commands::Build < Hanami::CLI::Command
    desc 'Build Phase from local Umwelt'

    argument :phase,
             type: :string, required: true,
             desc: 'provide project as USERNAME/PROJECTNAME'

    def call(phase:)
      puts "Buildung phase: <#{phase}>"
      # Generator::Element.new(element).create
    end
  end
end
