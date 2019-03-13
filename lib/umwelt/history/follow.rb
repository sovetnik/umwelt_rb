# frozen_string_literal: true

module Umwelt::History
  class Follow < Umwelt::Abstract::Interactor
    expose :episodes

    def initialize(
      reader: Umwelt::Episode::File::Restore,
      path: '.umwelt'
    )
      @reader = reader.new(path: path)
    end

    def call(phases)
      @episodes = phases.map { |phase| episode(phase) }
    end

    private

    def episode(phase)
      restored = restore_episode(phase.id)
      error! restored.errors if restored.failure?
      restored.struct
    end

    def restore_episode(phase_id)
      @reader.call(phase_id)
    end
  end
end
