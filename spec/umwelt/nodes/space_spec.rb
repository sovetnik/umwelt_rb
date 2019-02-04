# frozen_string_literal: true

require_relative '../../spec_helper'

describe Umwelt::Nodes::Space do
  subject { tree.node(member.id) }

  let(:tree) do
    Umwelt::Tree::Fill.new.call [root, parent, uncle, member]
  end

  let(:root) { Fabricate.build(:root, body: 'Project_root', kind: 'root') }
  let(:parent) { Fabricate.build(:parent, kind: 'space') }
  let(:uncle) { Fabricate.build(:uncle, kind: 'space') }
  let(:member) { Fabricate.build(:member, kind: 'space') }

  describe 'imprint' do
    let(:imprint) { subject.imprint(:Plain) }
    it 'is a node' do
      _(subject).must_be_instance_of described_class
    end

    it 'which builds imprint' do
      _(imprint).must_be_kind_of Umwelt::Semantics::Imprint
    end

    it 'which actually a imprint subclass' do
      _(imprint).must_be_instance_of Umwelt::Semantics::Plain::Space
    end
  end
end
