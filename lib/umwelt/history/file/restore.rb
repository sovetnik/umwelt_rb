# frozen_string_literal: true

require_relative '../../structs/history'

module Umwelt::History::File
  class Restore < Umwelt::File::Restore
    def initialize(
      path: '.umwelt/histories',
      mapper: Umwelt::History::Mapper
    )
      super
    end
  end
end
