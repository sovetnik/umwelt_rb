# frozen_string_literal: true

require_relative '../../spec_helper'

describe Umwelt::History::Follow do
  subject do
    interactor.call([phase_chaos, phase_discord])
  end

  let(:interactor) do
    Umwelt::History::Follow.new(reader: reader_class)
  end

  let(:reader_class) { Minitest::Mock.new }
  let(:reader) { Minitest::Mock.new }

  let(:phase_chaos) { Fabricate(:chaos) }
  let(:phase_discord) { Fabricate(:discord) }

  let(:episode_chaos) { Struct::Episode.new(phase: phase_chaos) }
  let(:episode_discord) { Struct::Episode.new(phase: phase_discord) }

  let(:result_chaos) { Minitest::Mock.new }
  let(:result_discord) { Minitest::Mock.new }

  before do
    reader_class.expect :new, reader, [{ path: '.umwelt' }]
    reader.expect :call, result_chaos, [phase_chaos.id]
    result_chaos.expect :failure?, false
    result_chaos.expect :struct, episode_chaos
  end

  describe 'when continuity respected' do
    before do
      reader.expect :call, result_discord, [phase_discord.id]
      result_discord.expect :failure?, false
      result_discord.expect :struct, episode_discord
    end

    it 'should be success' do
      _(subject.success?).must_equal true
    end

    it 'exposes episodes which contain given phases' do
      _(subject.episodes).must_be_instance_of Array
      _(subject.episodes).must_equal [
        episode_chaos,
        episode_discord
      ]
    end
  end

  describe 'when episode cannot be readen from file' do
    before do
      reader.expect :call, result_discord, [phase_discord.id]
      result_discord.expect :failure?, true
      result_discord.expect :errors, 'Phase with ID 0 not exist, but referenced'
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
