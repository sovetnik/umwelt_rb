# frozen_string_literal: true

require_relative '../structs/project'

module Umwelt::Mappers
  class Project < Base
    def call(data)
      @struct = fill(Struct::Project, data)
    end
  end
end
