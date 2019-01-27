# frozen_string_literal: true

Fabricator(:phase, from: Struct::Phase) do
  id { Fabricate.sequence(:phase) }
  parent_id { nil }
  merge_id { nil }
  user_id { Fabricate.sequence(:user) }
  finished_at Time.now
  name { Faker::Lovecraft.deity }
  description { Faker::Lovecraft.sentence }
  finished_at { Time.now }
end

Fabricator(:chaos, from: :phase) do
  id { 1 }
  parent_id { nil }
  merge_id { nil }
end

Fabricator(:discord, from: :phase) do
  id { 2 }
  parent_id { 1 }
  merge_id { nil }
end

Fabricator(:confusion, from: :phase) do
  id { 3 }
  parent_id { 2 }
  merge_id { nil }
end

Fabricator(:bureacracy, from: :phase) do
  id { 4 }
  parent_id { 2 }
  merge_id { 3 }
end

Fabricator(:aftermath, from: :phase) do
  id { 5 }
  parent_id { 4 }
  merge_id { nil }
end

Fabricator(:fnord, from: :phase) do
  id { 6 }
  parent_id { 3 }
  merge_id { nil }
end
