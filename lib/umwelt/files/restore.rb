# frozen_string_literal: true

require 'hanami/interactor'
require 'json'

module Umwelt::Files
  class Restore
    include Hanami::Interactor

    expose :struct, :full_path

    def initialize(path: '.umwelt',
                   builder: Struct)
      @path = path
      @builder = builder
    end

    def call(project_id)
      @full_path = full_path(project_id)
      @struct = struct parse(read_file)
    end

    private

    def read_file
      @full_path.read
    rescue Errno::ENOENT
      error! "Failed reading #{@full_path}"
    end

    def parse(str)
      JSON.parse(str, symbolize_names: true)
    rescue JSON::ParserError
      error! "Failed JSON parsing from #{@full_path}"
    end

    def struct(struct_hash)
      @builder.new(struct_hash)
    end

    def full_path(project_id)
      histories_path / "#{project_id}.json"
    end

    def histories_path
      Pathname.pwd / @path
    end
  end
end
