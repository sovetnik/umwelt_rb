# frozen_string_literal: true

module Umwelt::Project::File
  class Store < Umwelt::Abstract::File::Store
    def call(struct)
      count = write(full_path, struct)

      @written_paths[full_path] = count
    end

    def full_path
      umwelt_root_path / 'project.json'
    end
  end
end
