# frozen_string_literal: true

module Umwelt::CLI::Commands
  class Convey < Hanami::CLI::Command
    extend Forwardable
    def_delegators Hanami::Utils::String, :classify

    desc 'Convey Phase in Semantic from local Umwelt'

    argument :phase,
             type: :integer,
             required: true,
             desc: 'provide PHASE_ID to imprint'

    argument :semantic,
             type: :string,
             default: 'plain',
             values: %w[plain],
             required: true,
             desc: 'provide SEMANTIC to imprint'

    option :source,
           type: :string,
           default: '.umwelt',
           desc: 'provide folder where source stored'

    option :target,
           type: :string,
           default: 'umwelt',
           desc: 'provide folder for imprint'

    def call(phase:, semantic:, **options)
      puts "Buildung phase: #{phase} with semantic #{semantic}..."

      if phase.to_i.zero?
        puts 'Error: Phase must be an integer'
        return
      end

      @convey = Umwelt::Command::Convey.new.call(
        phase_id: phase.to_i,
        semantic: classify(semantic).to_sym,
        source: Pathname.new(options.fetch(:source)),
        target: Pathname.new(options.fetch(:target))
      )

      if @convey.success?
        @convey.result.each_pair do |key, value|
          puts "#{key} => (#{value})"
        end
        puts "#{@convey.result.keys.count} files written succesfully"
      else
        @convey.errors.each { |e| puts "Error: #{e}" }
      end
    end
  end
end
