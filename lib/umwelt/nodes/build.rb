# frozen_string_literal: true

module Umwelt::Nodes
  class Build
    extend Forwardable
    def_delegators Hanami::Utils::String, :classify

    def initialize(tree)
      @tree = tree
    end

    def call(frag)
      node_klass(frag.kind).new(attributes(frag))
    end

    private

    attr_reader :tree

    def attributes(frag)
      frag
        .to_h
        .slice(:id, :abstract_id, :context_id, :body, :note)
        .merge(tree: tree)
    end

    def node_klass(kind)
      Umwelt::Nodes.const_get classify(kind)
    end
  end
end
