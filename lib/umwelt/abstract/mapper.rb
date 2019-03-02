# frozen_string_literal: true

require 'hanami/interactor'
# require_relative './structs/phase'
# require_relative './structs/fragment'

class Umwelt::Abstract::Mapper
  include Hanami::Interactor

  expose :struct

  def fill(struct, data)
    struct.new(data)
  rescue ArgumentError => e
    error! [self.class.name, e.message, data]
  end
end
