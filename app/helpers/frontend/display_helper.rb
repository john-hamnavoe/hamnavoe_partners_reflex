# frozen_string_literal: true

module Frontend
  module DisplayHelper
    def priority_text(priority_id)
      case priority_id
      when 1
        "1 - Critical"
      when 2
        "2 - High"
      when 3
        "3 - Medium"
      when 4
        "4 - High"
      else
        ""
      end
    end
  end
end
