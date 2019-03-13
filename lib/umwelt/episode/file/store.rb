# frozen_string_literal: true

module Umwelt::Episode::File
  class Store < Umwelt::Abstract::File::Store
    def call(id, struct)
      count = write(full_path(id), struct)

      @written_paths[full_path(id)] = count
    end

    def full_path(id)
      umwelt_root_path / "episodes/#{id}.json"
    end
  end
end
