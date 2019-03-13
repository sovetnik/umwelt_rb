# frozen_string_literal: true

module Umwelt::History
  class Get < Umwelt::Abstract::Request
    expose :history

    def call(project_id)
      request = get(path: "histories/#{project_id}")

      @history = struct(parse(request), Mapper.new)
    end
  end
end
