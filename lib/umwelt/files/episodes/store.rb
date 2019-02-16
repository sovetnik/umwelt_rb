# frozen_string_literal: true

module Umwelt::Files::Episodes
  class Store < Umwelt::Files::Store
    def initialize(path: '.umwelt/episodes')
      super
    end
  end
end
