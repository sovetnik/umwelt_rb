# frozen_string_literal: true

Struct.new(
  'Phase',
  :id,
  :parent_id,
  :merge_id,
  :user_id,
  :finished_at,
  :name,
  :description,
  keyword_init: true
)
