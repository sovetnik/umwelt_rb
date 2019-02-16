# frozen_string_literal: true

require_relative '../../structs/history'

module Umwelt::Files::Project
  class Restore < Umwelt::Files::Restore
    def initialize(
      path: '.umwelt',
      mapper: Umwelt::Mappers::Project
    )
      super
    end

    def call
      @struct = struct parse read umwelt_root_path
    end
  end
end
