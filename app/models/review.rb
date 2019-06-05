class Review < ApplicationRecord
    belongs_to :user
    belongs_to :book

    validates_presence_of :description
    validates_presence_of :rating

    def self.positive
        where("rating >= 3")
    end

    def self.negative
        where("rating < 3")
    end
end
