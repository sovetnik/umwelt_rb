# frozen_string_literal: true

module Umwelt::Semantic
  class Base
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

    def code
      Unparser.unparse(ast)
    end

    # default_location defined, for example,
    # in Semantic::Plain::Base
    # or base file from another semantic
    def path(location: nil)
      Pathname.pwd / (location || default_location) / tail_path
    end

    # nil check for case of root node, which has not context
    def context
      node.context&.semantic(:Plain)
    end

    # classified symbol
    def csymbol
      classify(body).to_sym
    end

    def label
      self.class.name.split('::').last.to_sym
    end

    def tail_path
      Pathname.new(ancestry_path).sub_ext('.rb')
    end
  end
end
