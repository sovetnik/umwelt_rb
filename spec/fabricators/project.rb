# frozen_string_literal: true

Fabricator(:project, from: Struct::Project) do
  user_id { Fabricate.sequence(:user) }
  name { Faker::Ancient.unique.hero }
  description { Faker::Commerce.product_name }
end
