# frozen_string_literal: true

module Umwelt::CLI::Commands
  class Example < Hanami::CLI::Command
    desc 'Create example Umwelt'

    option :target,
           type: :string,
           default: '.umwelt',
           desc: 'provide target path (relative)'

    def call(**options)
      FileUtils.cp_r(
        examples_dir,
        target_dir(options.fetch(:target)),
        verbose: true
      )
    end

    def examples_dir
      Pathname.new(__dir__) / '../../../../spec/examples/.'
    end

    def target_dir(target)
      Pathname.pwd / target
    end
  end
end
