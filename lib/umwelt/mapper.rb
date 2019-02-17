# frozen_string_literal: true

require 'hanami/interactor'
# require_relative './structs/phase'
# require_relative './structs/fragment'
require_relative './utils'

class Umwelt::Mapper
  include Hanami::Interactor
  include Umwelt::Utils

  expose :struct

  def fill(struct, data)
    struct.new(data)
  rescue ArgumentError => e
    error! [self.class.name, e.message, data]
  end
end
