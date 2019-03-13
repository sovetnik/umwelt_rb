# frozen_string_literal: true

module Umwelt::Command
  class Convey < Base
    expose :written_paths

    def call(phase_id:, semantic:, source:, target:)
      @written_paths = imprint(
        tree(source, phase_id), target, semantic
      )
    end

    private

    def tree(source, phase_id)
      tree_fill(
        aggregate_history(
          follow_history(
            trace_history(
              restore_history(source),
              phase_id
            ), source
          )
        )
      )
    end

    def imprint(tree, target, semantic)
      prove(
        Umwelt::Tree::Imprint
        .new(tree, location: target)
        .call(semantic)
      ).written_paths
    end

    def tree_fill(fragments)
      Umwelt::Tree::Fill.new.call(fragments)
    end

    def aggregate_history(episodes)
      prove(
        Umwelt::History::Aggregate
        .new
        .call(episodes)
      ).fragments
    end

    def follow_history(continuity, source)
      prove(
        Umwelt::History::Follow
        .new(path: source)
        .call(continuity)
      ).episodes
    end

    def trace_history(history, phase_id)
      prove(
        Umwelt::History::Trace
        .new
        .call(history, phase_id)
      ).continuity
    end

    def restore_history(source)
      prove(
        Umwelt::History::File::Restore
        .new(path: source)
        .call
      ).struct
    end
  end
end
