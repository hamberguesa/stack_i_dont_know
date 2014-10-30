require 'rails_helper'
require 'spec_helper'

describe Question do
  before(:each) do
    @question = Question.new(title: "what?", content:"how?")
  end
  it 'has a title' do
    expect(@question.title).to eq "what?"
  end
  it 'has content' do
    expect(@question.content).to eq "how?"
  end
  it 'should have many answers' do
    should have_many(:answers)
  end
  it 'validates title exists' do
    should validate_presence_of(:title)
  end
  it 'validates content exists' do
    should validate_presence_of(:content)
  end

  it 'has a vote default value of 0' do
    expect(@question.vote).to eq(0)
  end

  after(:each) do
    @question = nil
  end
end

