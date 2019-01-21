# frozen_string_literal: true

module Umwelt::Utils
  def demodulize(klass)
    klass.name.split('::').last
  end
end
