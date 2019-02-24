# frozen_string_literal: true

require_relative '../../structs/episode'

module Umwelt::Episode::File
  class Restore < Umwelt::File::Restore
    def initialize(
      path: '.umwelt',
      mapper: Umwelt::Episode::Mapper
    )
      super
    end

    def call(phase_id)
      @struct = struct parse read full_path phase_id
    end

    def full_path(phase_id)
      umwelt_root_path / "episodes/#{phase_id}.json"
    end
  end
end
