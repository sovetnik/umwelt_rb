# frozen_string_literal: true

require_relative '../structs/phase'
require_relative '../structs/project'

module Umwelt::History
  class Mapper < Umwelt::Abstract::Mapper
    def call(
      data = {
        project: {},
        phases: []
      }
    )

      @struct = Struct::History.new(
        project: project(data[:project]),
        phases: phases(data[:phases])
      )
    end

    def phases(phases_data)
      phases_data.map { |phase_data| phase(phase_data) }
    end

    def project(data)
      fill(Struct::Project, data)
    end

    def phase(data)
      fill(Struct::Phase, data)
    end
  end
end
