class Question < ActiveRecord::Base
  has_many :answers, dependent: :destroy

  validates_presence_of :title, :content
end
