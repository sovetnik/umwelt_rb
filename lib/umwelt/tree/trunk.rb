# frozen_string_literal: true

require_relative '../structs/trunk'

module Umwelt::Tree
  class Trunk < Struct::Trunk
    def nodes
      index
        .values
        .map { |fragment| builder.call(fragment) }
    end

    def node(id)
      builder.call(index[id])
    end

    def childs(id)
      childs_ids[id].map { |child_id| node(child_id) }
    end

    private

    def builder
      @builder ||= Umwelt::Node::Build.new(self)
    end
  end
end
