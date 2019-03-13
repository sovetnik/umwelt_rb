# frozen_string_literal: true

module Umwelt::Command
  class Base
    include Hanami::Interactor

    def prove(result)
      result.success? ? result : error!(result.errors)
    end
  end
end

require_relative './command/clone'
require_relative './command/convey'
