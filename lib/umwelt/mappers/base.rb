# frozen_string_literal: true

require 'hanami/interactor'
require_relative '../structs/phase'
require_relative '../structs/fragment'
require_relative '../utils'

module Umwelt::Mappers
  class Base
    include Hanami::Interactor
    include Umwelt::Utils

    expose :struct

    def fill(struct, data)
      struct.new(data)
    rescue ArgumentError => e
      error! [demodulize(self.class), e.message, data]
    end
  end
end
