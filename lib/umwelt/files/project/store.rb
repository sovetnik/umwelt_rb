# frozen_string_literal: true

module Umwelt::Files::Project
  class Store < Umwelt::Files::Store
    def initialize(path: '.umwelt')
      super
    end

    def call(struct)
      umwelt_root_path.write serialize destruct struct
    end
  end
end
