# frozen_string_literal: true

Struct.new(
  'Project',
  :user_name,
  :project_name,
  :project_id,
  :description,
  keyword_init: true
)
