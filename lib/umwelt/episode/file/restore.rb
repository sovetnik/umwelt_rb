# frozen_string_literal: true

require_relative '../../structs/episode'

module Umwelt::Episode::File
  class Restore < Umwelt::File::Restore
    def initialize(
      path: '.umwelt/episodes',
      mapper: Umwelt::Episode::Mapper
    )
      super
    end
  end
end
