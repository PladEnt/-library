class Review < ApplicationRecord
    belongs_to :user
    belongs_to :book

    validates_presence_of :description
    validates_presence_of :rating

    def self.positive(reviews)
        reviews.collect do |review|
            if review.rating >= 3
                review.description
            end
        end
    end

    def self.negative(reviews)
        reviews.collect do |review|
            if review.rating < 3
                review.description
            end
        end
    end
end
