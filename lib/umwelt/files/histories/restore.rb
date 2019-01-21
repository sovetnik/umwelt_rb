# frozen_string_literal: true

require_relative '../../structs/history'

module Umwelt::Files::Histories
  class Restore < Umwelt::Files::Restore
    def initialize(
      path: '.umwelt/histories',
      mapper: Umwelt::Mappers::History
    )
      super
    end
  end
end
