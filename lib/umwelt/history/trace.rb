# frozen_string_literal: true

module Umwelt::History
  class Trace < Umwelt::Abstract::Interactor
    expose :continuity

    def initialize
      @queue = Queue.new # for phases
      @phases_index = {}
      @continuity = []
      @timeline = {}
    end

    def call(history, phase_id)
      to_index(history.phases)

      @queue.push from_index(phase_id)

      loop do
        break if @queue.empty?

        process(@queue.pop)
      end

      @continuity = @timeline.values
    end

    def process(phase)
      @timeline[phase[:id]] = phase
      enqueue(phase)
    end

    def enqueue(phase)
      @queue.push from_index(phase.merge_id) unless phase.merge_id.nil?
      @queue.push from_index(phase.parent_id) unless phase.parent_id.nil?
    end

    def from_index(phase_id)
      phase = @phases_index[phase_id]
      phase || error!("Phase with ID #{phase_id} not exist, but referenced")
    end

    def to_index(phases)
      phases.each do |phase|
        @phases_index[phase[:id]] = phase
      end
    end
  end
end
