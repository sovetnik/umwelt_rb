# frozen_string_literal: true

module Umwelt::Episode::File
  class Store < Umwelt::Abstract::File::Store
    def call(id, struct)
      full_path(id).dirname.mkpath

      full_path(id).write serialize(destruct(struct))
    end

    def full_path(id)
      umwelt_root_path / "episodes/#{id}.json"
    end
  end
end
