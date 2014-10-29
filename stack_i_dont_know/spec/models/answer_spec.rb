require 'rails_helper'
require 'spec_helper'

describe Answer do
  before(:each) do
    @answer = Answer.new(title: "this", content: "that")
  end
  it 'has a title' do
    expect(@answer.title).to eq "this"
  end
  it 'has content' do
    expect(@answer.content).to eq "that"
  end
  it 'belongs to a question' do
    should belong_to :question
  end
  it 'validates title exists' do
    should validate_presence_of(:title)
  end
  it 'validates content exists' do
    should validate_presence_of(:content)
  end

  after(:each) do
    @answer = nil
  end
end
