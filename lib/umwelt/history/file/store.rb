# frozen_string_literal: true

module Umwelt::History::File
  class Store < Umwelt::File::Store
    def initialize(path: '.umwelt/histories')
      super
    end
  end
end
