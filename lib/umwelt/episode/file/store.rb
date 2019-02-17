# frozen_string_literal: true

module Umwelt::Episode::File
  class Store < Umwelt::File::Store
    def initialize(path: '.umwelt/episodes')
      super
    end
  end
end
