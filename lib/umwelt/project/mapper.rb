# frozen_string_literal: true

require_relative '../structs/project'

module Umwelt::Project
  class Mapper < Umwelt::Abstract::Mapper
    def call(data)
      @struct = fill(Struct::Project, data)
    end
  end
end
