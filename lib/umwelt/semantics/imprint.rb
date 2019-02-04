# frozen_string_literal: true

module Umwelt::Semantics
  class Imprint
    extend Forwardable
    def_delegators Hanami::Utils::String, :classify, :underscore

    attr_reader :node

    def initialize(node:)
      @node = node
    end

    def s(type, *children)
      Parser::AST::Node.new(type, children)
    end

    def body
      node.body
    end

    def note
      node.note
    end

    def context
      node.context&.imprint(:Plain)
    end

    # classified symbol
    def csymbol
      classify(body).to_sym
    end

    def label
      self.class.name.split('::').last.to_sym
    end
  end
end
