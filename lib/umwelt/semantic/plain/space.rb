# frozen_string_literal: true

module Umwelt::Semantic::Plain
  class Space < Base
    def ast
      s(:module, const, nil)
    end

    def const
      s(:const, context&.const, csymbol)
    end
  end
end
