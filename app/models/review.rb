class Review < ApplicationRecord
    belongs_to :user
    belongs_to :book

    validates_presence_of :description
    validates_presence_of :rating

    def self.positive(reviews)
        positive_reviews = []
        reviews.collect do |review|
            if review.rating >= 3
                review.description
            end
        end
    end

    def self.negative(reviews)
        negative_reviews = []
        reviews.collect do |review|
            if review.rating < 3
                review.description
            end
        end
    end
end
