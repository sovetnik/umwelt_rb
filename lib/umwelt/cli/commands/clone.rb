# frozen_string_literal: true

module Umwelt::CLI
  class Commands::Clone < Hanami::CLI::Command
    desc 'Clone project from remote Umwelt'

    argument :project,
             type: :string, required: true,
             desc: 'provide project as USERNAME/PROJECTNAME'

    def call(project:)
      puts "Cloning project: <#{project}>"
      # Generator::Element.new(element).create
    end
  end
end
