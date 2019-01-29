# frozen_string_literal: true

module Umwelt::History
  class Aggregate
    include Hanami::Interactor

    expose :fragments

    def initialize
      @engaged = {}
      @forgotten = []
    end

    def call(episodes)
      # engaged = episodes.collect &:engaged
      # forgotten = episodes.collect &:forgotten

      episodes.each do |episode|
        index_engaged(episode.engaged)
        collect_forgotten(episode.forgotten)
      end

      verify_consistency

      @fragments = @engaged.slice(*alive_ids).values
    end

    private

    def alive_ids
      @engaged.keys - @forgotten
    end

    def fantom_ids
      @forgotten - @engaged.keys
    end

    def verify_consistency
      fantom_ids.empty? || error!("Aggregate failed: fantom ids: #{fantom_ids}")
    end

    def episode(phase)
      restored = restore_episode(phase.id)
      error! restored.errors if restored.failure?
      restored.struct
    end

    def collect_forgotten(ids)
      @forgotten.push(*ids)
    end

    def index_engaged(fragments)
      fragments.each do |fragment|
        @engaged[fragment[:id]] = fragment
      end
    end
  end
end
