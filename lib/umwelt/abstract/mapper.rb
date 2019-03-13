# frozen_string_literal: true

require 'hanami/interactor'
# require_relative './structs/phase'
# require_relative './structs/fragment'

module Umwelt::Abstract
  class Mapper < Umwelt::Abstract::Interactor
    expose :struct

    def fill(struct, data)
      struct.new(data)
    rescue ArgumentError => e
      error! [self.class.name, e.message, data]
    end
  end
end
