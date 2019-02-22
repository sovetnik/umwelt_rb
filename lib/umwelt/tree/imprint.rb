# frozen_string_literal: true

module Umwelt::Tree
  class Imprint
    extend Forwardable
    def_delegators FileUtils, :mkpath

    def initialize(trunk, location: nil)
      @trunk = trunk
      @location = location
    end

    def call(semantic_name)
      @trunk.nodes.map do |node|
        write node.semantic(semantic_name)
      end
    end

    private

    def write(semantic)
      path = semantic.path(location: @location)

      mkpath path.dirname

      count = path.write(semantic.code)

      Hash[path.to_s, count]
    end
  end
end
