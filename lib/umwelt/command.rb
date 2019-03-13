# frozen_string_literal: true

module Umwelt::Command
  class Base < Umwelt::Abstract::Interactor
  end
end

require_relative './command/clone'
require_relative './command/convey'
