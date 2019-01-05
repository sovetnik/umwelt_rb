# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'umwelt'

require 'minitest/autorun'
require 'minitest/reporters'

Minitest::Reporters.use! [
  # Minitest::Reporters::SpecReporter.new,
  Minitest::Reporters::ProgressReporter.new
]
