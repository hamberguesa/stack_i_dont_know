class Answer < ActiveRecord::Base
  belongs_to :question

  validates_presence_of :title, :content

  def upvote
    self.vote += 1
  end

  def downvote
    self.vote -= 1
  end
end
