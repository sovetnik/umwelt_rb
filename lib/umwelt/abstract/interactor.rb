# frozen_string_literal: true

require 'hanami/interactor'
# require_relative './structs/phase'
# require_relative './structs/fragment'

module Umwelt::Abstract
  class Interactor
    include Hanami::Interactor

    def prove(result)
      result.success? ? result : error!(result.errors)
    end
  end
end
