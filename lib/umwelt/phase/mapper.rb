# frozen_string_literal: true

require_relative '../structs/phase'

module Umwelt::Phase
  class Mapper < Umwelt::Mapper
    def call(data)
      @struct = fill(
        Struct::Phase,
        data.merge(finished_at: time(data[:finished_at]))
      )
    end

    def time(str)
      Time.parse str if str
    end
  end
end
