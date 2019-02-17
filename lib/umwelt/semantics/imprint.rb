# frozen_string_literal: true

module Umwelt::Semantics
  class Imprint
    extend Forwardable
    def_delegators Hanami::Utils::String, :classify, :underscore
    def_delegators :node, :ancestry, :body, :note

    attr_reader :node

    def initialize(node:)
      @node = node
    end

    def s(type, *children)
      Parser::AST::Node.new(type, children)
    end

    def ancestry_path
      ancestry
        .collect(&:body)
        .map { |body| underscore(body) }
        .join '/'
    end

    def path
      Pathname.new(ancestry_path).sub_ext('.rb')
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
