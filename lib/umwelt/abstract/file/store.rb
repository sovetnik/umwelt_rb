# frozen_string_literal: true

require 'hanami/interactor'
require 'json'
require 'fileutils'
require 'pathname'

module Umwelt::Abstract::File
  class Store
    include Hanami::Interactor

    expose :written_paths

    def initialize(path: '.umwelt')
      @path = path
      @written_paths = {}
    end

    private

    def write(path, struct)
      path.dirname.mkpath

      path.write serialize destruct struct
    end

    def serialize(struct)
      JSON.pretty_generate struct
    end

    def destruct(obj)
      obj.is_a?(Struct) ? destruct_members(obj.to_h) : obj
    end

    def destruct_members(hash)
      hash.transform_values do |value|
        if value.is_a?(Array)
          value.map { |member| destruct(member) }
        elsif value.is_a? Time
          value.to_s
        else
          destruct(value)
        end
      end
    end

    def umwelt_root_path
      Pathname.pwd / @path
    end
  end
end
