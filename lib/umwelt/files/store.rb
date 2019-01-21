# frozen_string_literal: true

require 'hanami/interactor'
require 'json'
require 'fileutils'
require 'pathname'

module Umwelt::Files
  class Store
    extend Forwardable
    include Hanami::Interactor
    def_delegators FileUtils, :mkpath

    def initialize(path: '.umwelt')
      @path = path
    end

    def call(id, struct)
      mkpath directory_path

      full_path(id).write serialize(destruct(struct))
    end

    private

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

    def full_path(id)
      directory_path / "#{id}.json"
    end

    def directory_path
      Pathname.pwd / @path
    end
  end
end
