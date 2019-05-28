class Book < ApplicationRecord
    has_many  :reviews
    has_many :reviewed_users, through: :reviews, source: :user
    belongs_to :user

    validates_presence_of :title
    validates_presence_of :auther
end
