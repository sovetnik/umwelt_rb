# frozen_string_literal: true

require_relative '../../structs/history'

module Umwelt::History::File
  class Restore < Umwelt::Abstract::File::Restore
    def initialize(
      path: '.umwelt',
      mapper: Umwelt::History::Mapper
    )
      super
    end

    def call
      @struct = struct parse read full_path
    end

    def full_path
      umwelt_root_path / 'history.json'
    end
  end
end
