# frozen_string_literal: true

module Umwelt::Files::Histories
  class Store < Umwelt::Files::Store
    def initialize(path: '.umwelt/histories')
      super
    end
  end
end
