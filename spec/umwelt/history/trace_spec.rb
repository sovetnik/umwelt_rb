# frozen_string_literal: true

require_relative '../../spec_helper'

describe Umwelt::History::Trace do
  subject do
    interactor.call(history, aftermath.id)
  end

  let(:interactor) do
    Umwelt::History::Trace.new
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
      phases: [chaos, discord, confusion, bureacracy, aftermath, fnord]
    )
  end

  let(:project) { Fabricate(:project) }

  let(:chaos) { Fabricate(:chaos) }
  let(:discord) { Fabricate(:discord) }
  let(:confusion) { Fabricate(:confusion) }
  let(:bureacracy) { Fabricate(:bureacracy) }
  let(:aftermath) { Fabricate(:aftermath) }
  let(:fnord) { Fabricate(:fnord, parent_id: non_exist_id) }
  let(:non_exist_id) { 0 }

  describe 'when continuity respected' do
    it 'should be success' do
      _(subject.success?).must_equal true
    end

    it 'exposes continuity of phases from requested to first' do
      _(subject.continuity).must_be_instance_of Array
      _(subject.continuity).must_equal [
        aftermath,
        bureacracy,
        confusion,
        discord,
        chaos
      ]
    end
  end

  describe 'when continuity is broken' do
    subject do
      interactor.call(history, fnord.id)
    end

    it 'should be failed' do
      _(subject.failure?).must_equal true
    end

    it 'fails with errors' do
      _(subject.errors).must_equal [
        'Phase with ID 0 not exist, but referenced'
      ]
    end
  end
end
