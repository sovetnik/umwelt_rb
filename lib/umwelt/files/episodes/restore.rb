# frozen_string_literal: true

require_relative '../../structs/episode'

module Umwelt::Files::Episodes
  class Restore < Umwelt::Files::Restore
    def initialize(
      path: '.umwelt/episodes',
      mapper: Umwelt::Mappers::Episode
    )
      super
    end
  end
end
