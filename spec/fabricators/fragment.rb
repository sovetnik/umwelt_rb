# frozen_string_literal: true

Fabricator(:fragment, from: Struct::Fragment) do
  abstract_id nil
  context_id nil
  origin_id nil

  kind 'space'
  body { Faker::Ancient.titan }
  note { "#{Faker::Hacker.adjective} #{Faker::Hacker.noun}" }
end

Fabricator(:root, from: :fragment) do
  id 1
  kind 'base'
  body 'root'
  note 'description of root'
  context_id nil
end

Fabricator(:parent, from: :fragment) do
  id 2
  kind 'space'
  body 'parent'
  note 'description of parent'
  context_id 1
end

Fabricator(:uncle, from: :fragment) do
  id 3
  kind 'space'
  body 'uncle'
  note 'description of uncle'
  context_id 1
end

Fabricator(:member, from: :fragment) do
  id 4
  kind 'space'
  body 'member'
  note 'description of member'
  context_id 2
  abstract_id 3
end

Fabricator(:sibling, from: :fragment) do
  id 5
  kind 'space'
  body 'sibling'
  note 'description of sibling'
  context_id 2
end

Fabricator(:child_one, from: :fragment) do
  id 6
  body 'child_one'
  note 'description of child_one'
  context_id 4
end

Fabricator(:child_two, from: :fragment) do
  id 7
  body 'child_two'
  note 'description of child_two'
  context_id 4
end

Fabricator(:cousin, from: :fragment) do
  id 8
  body 'cousin'
  note 'description of cousin'
  context_id 3
end

Fabricator(:nephew, from: :fragment) do
  id 9
  kind 'lemma'
  body 'nephew'
  note 'description of nephew'
  context_id 8
end
