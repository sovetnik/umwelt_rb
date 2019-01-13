# frozen_string_literal: true

require 'hanami/interactor'

module Umwelt::Files::Episodes
  class Store < Umwelt::Files::Store
    def initialize(path: '.umwelt/episodes')
      @path = path
    end
  end
end
