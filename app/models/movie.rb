class Movie < ApplicationRecord
    def flop?
        total_gross.blank? || total_gross < 3_000_000_001
    end
end
