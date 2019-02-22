# frozen_string_literal: true

module Umwelt::Semantic::Plain
  class Root < Base
    def ast
      s(:module, const, nil)
    end

    def const
      s(:const, nil, csymbol)
    end
  end
end
