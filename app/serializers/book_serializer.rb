class BookSerializer < ActiveModel::Serializer
  attributes :id, :title, :auther
  has_many :reviews
end
