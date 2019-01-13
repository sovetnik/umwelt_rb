# frozen_string_literal: true

require 'hanami/interactor'

module Umwelt::Files::Histories
  class Store < Umwelt::Files::Store
    def initialize(path: '.umwelt/histories')
      @path = path
    end
  end
end
