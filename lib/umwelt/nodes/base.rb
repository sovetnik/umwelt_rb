# frozen_string_literal: true

require_relative '../structs/node'

module Umwelt::Nodes
  class Base < Struct::Node
    def imprints
      [:Plain]
    end

    def imprint(name)
      imprint_klass(name).new(node: self)
    end

    def context
      tree.node(context_id)
    end

    def label
      self.class.name.split('::').last.to_sym
    end

    private

    # Umwelt::Nodes::Space.new.imprint_klass(imprint)
    # => Umwelt::Semantics::Plain::Space
    def imprint_klass(imprint)
      [imprint, label].reduce(Umwelt::Semantics) do |klass, name|
        klass.const_get name
      end
    end
  end
end
