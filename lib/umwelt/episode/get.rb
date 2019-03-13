# frozen_string_literal: true

module Umwelt::Episode
  class Get < Umwelt::Abstract::Request
    expose :episode

    def call(phase_id)
      request = get(path: "episodes/#{phase_id}")

      @episode = struct(parse(request), Mapper.new)
    end
  end
end
