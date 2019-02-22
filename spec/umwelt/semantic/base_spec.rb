# frozen_string_literal: true

require_relative '../../spec_helper'

describe Umwelt::Semantic::Base do
  subject { tree.node(member.id).semantic(:Plain) }

  let(:tree) do
    Umwelt::Tree::Fill.new.call [root, parent, uncle, member]
  end

  let(:root) { Fabricate.build(:root, body: 'Project_root', kind: 'root') }
  let(:parent) { Fabricate.build(:parent, kind: 'space') }
  let(:uncle) { Fabricate.build(:uncle, kind: 'space') }
  let(:member) { Fabricate.build(:member, kind: 'space') }

  describe '#ancestry' do
    it 'returnes collection of ancestors' do
      _(subject.ancestry).must_equal [
        tree.node(root.id),
        tree.node(parent.id),
        tree.node(member.id)
      ]
    end
  end

  describe '#context' do
    let(:element) { tree.node(member.id) }
    it 'returnes context of element' do
      _(subject.context.body).must_equal parent.body
      _(subject.context).must_be_instance_of Umwelt::Semantic::Plain::Space
    end
  end

  describe 'node' do
    it 'returnes node' do
      _(subject).must_be_kind_of described_class
    end

    it 'returnes node' do
      _(subject).must_be_instance_of Umwelt::Semantic::Plain::Space
    end
  end
end
