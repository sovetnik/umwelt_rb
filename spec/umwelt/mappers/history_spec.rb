# frozen_string_literal: true

require_relative '../../spec_helper'

describe Umwelt::Mappers::History do
  subject do
    interactor.call(history_data)
  end
  let(:interactor) do
    Umwelt::Mappers::History.new
  end

  let(:history_data) do
    Struct::History.new(
      project: project.to_h,
      phases: [phase.to_h]
    ).to_h
  end

  let(:history) do
    Struct::History.new(
      project: project,
      phases: [phase]
    )
  end

  let(:project) do
    Struct::Project.new(
      name: 'chaos',
      description: 'Viva Discordia'
    )
  end

  let(:phase) do
    Struct::Phase.new(
      id: 13,
      parent_id: 5,
      merge_id: nil,
      user_id: 1,
      finished_at: Time.now.to_s,
      name: 'feature',
      description: 'implementing feature'
    )
  end

  describe 'when data is good' do
    it 'should be success' do
      _(subject.success?).must_equal true
    end

    it 'exposes history' do
      _(subject.struct).must_be_kind_of Struct::History
      _(subject.struct).must_equal history
    end
  end

  describe 'when data is not match' do
    let(:history_data) do
      {
        project: { shit: :happens },
        phases: [phase.to_h]
      }
    end

    it 'should be failed' do
      _(subject.failure?).must_equal true
    end

    it 'fails with errors' do
      _(subject.errors).must_equal [
        'History',
        'unknown keywords: shit',
        { shit: :happens }
      ]
    end
  end
end
