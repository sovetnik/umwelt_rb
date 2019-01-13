# frozen_string_literal: true

require 'hanami/interactor'
require_relative '../../structs/episode'

module Umwelt::Files::Episodes
  class Restore < Umwelt::Files::Restore
    def initialize(
      path: '.umwelt/episodes',
      builder: Struct::Episode
    )
      super
    end
  end
end
