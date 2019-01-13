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

      full_path(id).write serialize(struct)
    end

    private

    def serialize(struct)
      JSON.pretty_generate struct.to_h
    end

    def full_path(id)
      directory_path / "#{id}.json"
    end

    def directory_path
      Pathname.pwd / @path
    end
  end
end
