# frozen_string_literal: true

require 'hanami/interactor'
require_relative '../../structs/history'

module Umwelt::Files::Histories
  class Restore < Umwelt::Files::Restore
    def initialize(
      path: '.umwelt/histories',
      builder: Struct::History
    )
      super
    end
  end
end
