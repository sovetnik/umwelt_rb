# frozen_string_literal: true

module Umwelt::History::File
  class Store < Umwelt::Abstract::File::Store
    def call(struct)
      full_path.dirname.mkpath

      full_path.write serialize destruct struct
    end

    def full_path
      umwelt_root_path / 'history.json'
    end
  end
end
