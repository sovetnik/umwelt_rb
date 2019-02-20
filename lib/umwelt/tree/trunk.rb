# frozen_string_literal: true

module Umwelt::Tree
  class Trunk
    def initialize(index: {},
                   childs_ids: {})
      @index = index
      @childs_ids = childs_ids
    end

    def each_node(&block)
      @index
        .values
        .map { |fragment| builder.call(fragment) }
        .each(&block)
    end

    def node(id)
      builder.call(@index[id])
    end

    def childs(id)
      @childs_ids[id].map { |child_id| node(child_id) }
    end

    private

    def builder
      @builder ||= Umwelt::Nodes::Build.new(self)
    end
  end
end
