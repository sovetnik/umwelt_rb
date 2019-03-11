# frozen_string_literal: true

module Umwelt::Project
  class Get < Umwelt::Abstract::Request
    expose :project

    # query = {
    #   project_name: 'genry',
    #   user_name: 'ford'
    # }

    def call(query)
      request = get(
        path: 'projects/find',
        params: { query: query }
      )

      @project = struct(parse(request), Mapper.new)
    end
  end
end
