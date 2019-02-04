# frozen_string_literal: true

Struct.new(
  'Node',
  :id,
  :abstract_id,
  :context_id,
  :origin_id,
  :body,
  :note,
  :tree,
  keyword_init: true
)
