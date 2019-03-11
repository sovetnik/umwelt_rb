# frozen_string_literal: true

require 'hanami/interactor'
require 'httparty'

class Umwelt::Abstract::Request
  BASE_URL = 'http://umwelt.dev/api'
  # BASE_URL = 'http://localhost:2300/api'
  HEADERS = {
    'Content-Type': 'application/json',
    'User-Agent': "Umwelt client #{Umwelt::VERSION}",
    'Accept': 'application/json'
  }.freeze

  include Hanami::Interactor

  def get(host: BASE_URL, path: '', params: {})
    check HTTParty.get(
      [host, path].join('/'), options(params)
    )
  rescue StandardError => e
    error! [self.class.name, e.message, path]
  end

  def check(request)
    if request.parsed_response.key?('errors')
      error! request.parsed_response['errors']
    else
      request
    end
  end

  def parse(request)
    request
      .parsed_response
      .transform_keys(&:to_sym)
  end

  def struct(data, mapper)
    result = mapper.call(data)
    if result.success?
      result.struct
    else
      error! result.errors
    end
  end

  def options(params)
    { headers: HEADERS, format: :json }.merge(params)
  end
end
