# frozen_string_literal: true

require_relative '../../../spec_helper'

describe Umwelt::Semantic::Plain::Base do
  subject do
    described_class.new(node: tree.node(root.id))
  end

  let(:tree) do
    Umwelt::Tree::Fill.new.call [root]
  end

  let(:root) { Fabricate.build(:root, body: 'project_root', kind: 'root') }

  describe '#default_location' do
    it 'returnes middle of path' do
      _(subject.default_location).must_equal Pathname.new('umwelt/lib')
    end
  end
end
