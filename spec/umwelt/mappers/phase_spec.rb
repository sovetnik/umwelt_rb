# frozen_string_literal: true

require_relative '../../spec_helper'

describe Umwelt::Mappers::Phase do
  subject do
    interactor.call(phase_data)
  end

  let(:interactor) do
    Umwelt::Mappers::Phase .new
  end

  let(:finished) { Time.now }

  let(:phase_data) do
    {
      id: 13,
      parent_id: 5,
      merge_id: nil,
      user_id: 1,
      finished_at: finished.to_s,
      name: 'feature',
      description: 'implementing feature'
    }
  end

  let(:phase) do
    Struct::Phase.new(
      id: 13,
      parent_id: 5,
      merge_id: nil,
      user_id: 1,
      finished_at: finished,
      name: 'feature',
      description: 'implementing feature'
    )
  end

  describe 'when data is good' do
    it 'should be success' do
      _(subject.success?).must_equal true
    end

    it 'exposes phase' do
      _(subject.struct).must_be_kind_of Struct::Phase
      _(subject.struct.to_h.slice(
          :id, :parent_id, :merge_id, :user_id, :name, :description
        )).must_equal phase.to_h.slice(
          :id, :parent_id, :merge_id, :user_id, :name, :description
        )
    end
  end

  describe 'when data is wrong' do
    let(:failed) { interactor.call(shit: :happens) }

    it 'should be failed' do
      _(failed.failure?).must_equal true
    end

    it 'fails with errors' do
      _(failed.errors).must_equal [
        'Phase',
        'unknown keywords: shit',
        { shit: :happens, finished_at: nil }
      ]
    end
  end
end
