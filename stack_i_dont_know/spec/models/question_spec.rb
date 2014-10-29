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

  after(:each) do
    @question = nil
  end
end

