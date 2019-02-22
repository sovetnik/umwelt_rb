# frozen_string_literal: true

module Umwelt::Semantic::Plain
  class Base < Umwelt::Semantic::Base
    def default_location
      Pathname.new 'umwelt/lib'
    end
  end
end
