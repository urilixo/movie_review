class Movie < ApplicationRecord
    def self.released
        where("released_on < ?", Time.now)
    end

    def self.flop
        where("total_gross <= ?", 225_000_000)
    end

    def self.hit
        where('total_gross >= ?', 300_000_000)
    end

    def self.recently_added
        order("created_at desc").limit(3)
    end

    def flop?
        total_gross.blank? || total_gross < 250_000_000
    end
end
