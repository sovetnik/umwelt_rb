# frozen_string_literal: true

module Umwelt::CLI
  class Commands::Clone < Hanami::CLI::Command
    desc 'Clone project from remote Umwelt'

    argument :user_project,
             type: :string, required: true,
             desc: 'provide project as USERNAME/PROJECTNAME'

    option :target,
           type: :string,
           default: '.umwelt',
           desc: 'provide folder for store umwelt'

    def call(user_project:, **options)
      puts "Cloning project: <#{user_project}>"
      puts options.inspect
      puts options.fetch(:target)

      result = Umwelt::Command::Clone
               .new(path: options.fetch(:target))
               .call(user_project: user_project)
      if result.success?
        result.written_paths.each_pair do |key, value|
          puts "#{key} => (#{value})"
        end
        puts "#{result.result.keys.count} files written succesfully"
      else
        result.errors.each { |e| puts "Error: #{e}" }
      end
    end
  end
end
