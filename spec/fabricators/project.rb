# frozen_string_literal: true

Fabricator(:project, from: Struct::Project) do
  user_name { Faker::Internet.username }
  project_name { Faker::Books::Lovecraft.word }
  project_id { Fabricate.sequence(:project) }
  description { Faker::Commerce.product_name }
end
