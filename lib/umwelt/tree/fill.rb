# frozen_string_literal: true

module Umwelt::Tree
  class Fill
    def initialize
      @index = {}
      @childs_ids = {}
    end

    def call(fragments)
      fragments.each do |fragment|
        add_to_index(fragment)
        register_as_child(fragment)
      end
      fill_tank
    end

    private

    def add_to_index(fragment)
      @index[fragment.id] = fragment
    end

    def register_as_child(fragment)
      return if fragment.context_id.nil?

      @childs_ids[fragment.context_id] ||= []
      @childs_ids[fragment.context_id] << fragment.id
    end

    def fill_tank
      Tank.new(index: @index, childs_ids: @childs_ids)
    end
  end
end
