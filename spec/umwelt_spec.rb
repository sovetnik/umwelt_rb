# frozen_string_literal: true

require_relative './spec_helper'

describe Umwelt do
  it 'has a version number' do
    _(Umwelt::VERSION).must_be_instance_of String
  end
end
