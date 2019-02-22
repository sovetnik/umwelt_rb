# frozen_string_literal: true

require_relative '../../spec_helper'
describe Umwelt::Tree::Imprint do
  subject do
    Umwelt::Tree::Imprint.new(trunk, location: temp)
  end

  let(:trunk) do
    Umwelt::Tree::Fill.new.call [parent, member]
  end

  let(:temp) { 'tmp' }

  let(:parent) { Fabricate.build(:root, body: 'parent', kind: 'root') }
  let(:member) do
    Fabricate.build(:member, kind: 'space', context_id: parent.id)
  end

  let(:parent_code) { trunk.node(parent.id).semantic(:Plain).code }
  let(:member_code) { trunk.node(member.id).semantic(:Plain).code }

  let(:parent_path) do
    trunk.node(parent.id).semantic(:Plain).path(location: temp)
  end
  let(:member_path) do
    trunk.node(member.id).semantic(:Plain).path(location: temp)
  end

  after do
    parent_path.delete
    member_path.delete
  end

  it 'writes code from tree to files' do
    _(parent_path.exist?).must_equal false
    _(member_path.exist?).must_equal false

    written_paths = subject.call(:Plain)

    _(parent_path.exist?).must_equal true
    _(member_path.exist?).must_equal true

    _(parent_path.read).must_equal parent_code
    _(member_path.read).must_equal member_code

    _(written_paths).must_equal [
      { parent_path.to_s => 17 },
      { member_path.to_s => 25 }
    ]
  end
end
