# frozen_string_literal: true

module Umwelt::Project::File
  class Store < Umwelt::Abstract::File::Store
    def call(struct)
      mkpath full_path.dirname

      full_path.write serialize destruct struct
    end

    def full_path
      umwelt_root_path / 'project.json'
    end
  end
end
