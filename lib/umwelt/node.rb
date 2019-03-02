# frozen_string_literal: true

require_relative './structs/node'

module Umwelt::Node
  class Base < Struct::Node
    def semantics
      [:Plain]
    end

    def semantic(semantic_name)
      semantic_klass(semantic_name).new(node: self)
    end

    def ancestry
      if context_id
        context.ancestry << self
      else
        [self]
      end
    end

    def context
      tree.node(context_id)
    end

    def label
      self.class.name.split('::').last.to_sym
    end

    private

    # Umwelt::Node::Space.new.semantic_klass(semantic)
    # => Umwelt::Semantic::Plain::Space
    def semantic_klass(semantic_name)
      [semantic_name, label]
        .reduce(Umwelt::Semantic) do |klass, name|
        klass.const_get name
      end
    end
  end
end

require_relative './node/build'
require_relative './node/root'
require_relative './node/space'
