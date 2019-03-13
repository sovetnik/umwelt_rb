# frozen_string_literal: true

require 'hanami/interactor'
require 'json'

module Umwelt::Abstract::File
  class Restore < Umwelt::Abstract::Interactor
    expose :struct

    def initialize(path: '.umwelt',
                   mapper: Struct)
      @path = path
      @mapper = mapper
    end

    private

    def read(path)
      path.read
    rescue Errno::ENOENT
      error! "Failed reading #{path}"
    end

    def parse(str)
      JSON.parse(str, symbolize_names: true)
    rescue JSON::ParserError
      error! "Failed JSON parsing #{self.class.name}"
    end

    def struct(struct_hash)
      prove(
        @mapper.new.call(struct_hash)
      ).struct
    end

    def umwelt_root_path
      Pathname.pwd / @path
    end
  end
end
