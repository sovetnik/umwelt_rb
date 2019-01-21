# frozen_string_literal: true

Struct.new(
  'Fragment',
  :id,
  :abstract_id,
  :context_id,
  :kind,
  :body,
  :note,
  keyword_init: true
)
