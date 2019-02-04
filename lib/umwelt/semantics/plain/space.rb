# frozen_string_literal: true

module Umwelt::Semantics::Plain
  class Space < Umwelt::Semantics::Imprint
    def to_ast
      s(:module, const, nil)
    end

    def const
      s(:const, context&.const, csymbol)
    end
  end
end
