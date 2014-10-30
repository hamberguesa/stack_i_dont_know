class Question < ActiveRecord::Base
  has_many :answers, dependent: :destroy

  validates_presence_of :title, :content

  def upvote
    self.vote += 1
  end

  def downvote
    self.vote -= 1
  end
end
