# frozen_string_literal: true

module Umwelt::Command
  class Convey
    include Hanami::Interactor
    # TODO: change to dry-rb transaction here

    expose :result

    def call(phase_id:, semantic:, source:, target:)
      @result = imprint(
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
      result = Umwelt::Tree::Imprint.new(tree, location: target).call(semantic)
      if result.success?
        result.written_paths
      else
        error! result.errors
      end
    end

    def tree_fill(fragments)
      Umwelt::Tree::Fill.new.call(fragments)
    end

    def aggregate_history(episodes)
      result = Umwelt::History::Aggregate.new.call(episodes)
      if result.success?
        result.fragments
      else
        error! result.errors
      end
    end

    def follow_history(continuity, source)
      result = Umwelt::History::Follow
               .new(path: source)
               .call(continuity)
      if result.success?
        result.episodes
      else
        error! result.errors
      end
    end

    def trace_history(history, phase_id)
      result = Umwelt::History::Trace.new.call(history, phase_id)
      if result.success?
        result.continuity
      else
        error! result.errors
      end
    end

    def restore_history(source)
      restored = Umwelt::History::File::Restore
                 .new(path: source)
                 .call
      if restored.success?
        restored.struct
      else
        error! "Cannot restore history from '#{source}': #{restored.errors}"
      end
    end
  end
end
