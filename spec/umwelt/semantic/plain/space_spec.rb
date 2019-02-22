# frozen_string_literal: true

require_relative '../../../spec_helper'

describe Umwelt::Semantic::Plain::Space do
  subject do
    described_class.new(node: node)
  end

  let(:node) { MiniTest::Mock.new }
  let(:context) { MiniTest::Mock.new }
  let(:semantic_of_context) { described_class.new(node: context) }

  before do
    node.expect(:body, 'inner_space')
  end

  after do
    node.verify
    context.verify
  end

  describe '#path' do
    before do
      node.expect(:ancestry, [context, node])
      context.expect(:body, 'outer_space')
    end

    it 'returnes relative path' do
      _(subject.path)
        .must_equal Pathname.pwd / 'umwelt/lib/outer_space/inner_space.rb'
    end
  end

  describe '#ast' do
    before do
      node.expect(:context, context)

      context.expect(:semantic, semantic_of_context, [:Plain])
      context.expect(:body, 'outer_space')
      context.expect(:context, nil)
    end

    it 'returnes ast node' do
      _(subject.ast).must_equal s(
        :module,
        s(
          :const,
          s(
            :const,
            nil,
            :OuterSpace
          ),
          :InnerSpace
        ), nil
      )
    end

    it 'can be unparsed to' do
      _(Unparser.unparse(subject.ast))
        .must_equal "module OuterSpace::InnerSpace\nend"
    end
  end

  describe 'csymbol' do
    it 'returnes classified symbolized body' do
      _(subject.csymbol).must_equal :InnerSpace
    end
  end
end
