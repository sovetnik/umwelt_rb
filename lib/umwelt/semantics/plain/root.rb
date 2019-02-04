# frozen_string_literal: true

module Umwelt::Semantics::Plain
  class Root < Umwelt::Semantics::Imprint
    def to_ast
      s(:module, const, nil)
    end

    def const
      s(:const, nil, csymbol)
    end
  end
end
