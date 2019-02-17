# frozen_string_literal: true

module Umwelt::Project::File
  class Store < Umwelt::File::Store
    def initialize(path: '.umwelt')
      super
    end

    def call(struct)
      umwelt_root_path.write serialize destruct struct
    end
  end
end
