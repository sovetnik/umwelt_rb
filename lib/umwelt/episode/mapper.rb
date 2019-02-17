# frozen_string_literal: true

require_relative '../structs/phase'
require_relative '../structs/fragment'

module Umwelt::Episode
  class Mapper < Umwelt::Mapper
    def call(
      data = {
        phase: {},
        engaged: [],
        forgotten: []
      }
    )

      @struct = Struct::Episode.new(
        phase: phase(data[:phase]),
        engaged: fragments(data[:engaged]),
        forgotten: data[:forgotten]
      )
    end

    private

    def fragments(array)
      array.map { |data| fill(Struct::Fragment, data) }
    end

    def phase(data)
      fill(Struct::Phase, data)
    end
  end
end
