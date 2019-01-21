# frozen_string_literal: true

require_relative '../../spec_helper'

describe Umwelt::Mappers::Fragment do
  subject do
    interactor.call(fragment.to_h)
  end

  let(:interactor) do
    Umwelt::Mappers::Fragment.new
  end

  let(:fragment) do
    Struct::Fragment.new(
      id: 13,
      abstract_id: 5,
      context_id: nil,
      kind: 'space',
      body: 'foo',
      note: 'foo bar baz'
    )
  end

  describe 'when data is good' do
    it 'should be success' do
      _(subject.success?).must_equal true
    end

    it 'exposes fragment' do
      _(subject.struct).must_be_kind_of Struct::Fragment
      _(subject.struct).must_equal fragment
    end
  end

  describe 'when data is wrong' do
    let(:failed) { interactor.call(shit: :happens) }

    it 'should be failed' do
      _(failed.failure?).must_equal true
    end

    it 'fails with errors' do
      _(failed.errors).must_equal [
        'Fragment',
        'unknown keywords: shit',
        { shit: :happens }
      ]
    end
  end
end
