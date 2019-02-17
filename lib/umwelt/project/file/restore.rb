# frozen_string_literal: true

require_relative '../../structs/history'

module Umwelt::Project::File
  class Restore < Umwelt::File::Restore
    def initialize(
      path: '.umwelt',
      mapper: Umwelt::Project::Mapper
    )
      super
    end

    def call
      @struct = struct parse read umwelt_root_path
    end
  end
end
