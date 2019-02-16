# frozen_string_literal: true

require_relative '../structs/fragment'

module Umwelt::Mappers
  class Fragment < Base
    def call(data)
      @struct = fill(Struct::Fragment, data)
    end
  end
end
