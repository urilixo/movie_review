class Movie < ApplicationRecord
    def flop?
        total_gross.blank? || total_gross < 250_000_000
    end
end
