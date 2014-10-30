class AddVotesColumn < ActiveRecord::Migration
  def change
    add_column :questions, :votes, :integer, default: 0
    add_column :answers, :votes, :integer, default: 0
  end
end
