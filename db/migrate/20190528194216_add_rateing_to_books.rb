class AddRateingToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column(:books, :rateing, :integer)
  end
end
