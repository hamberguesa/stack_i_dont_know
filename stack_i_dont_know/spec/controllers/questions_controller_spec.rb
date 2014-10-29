require 'rails_helper'
require 'spec_helper'

describe QuestionsController do
  before(:each) do
    @question = Question.create(:title => "What is AJAX?", :content => "AJAX for what?")
    @answer = @question.answers.create(:title => "AJAX is awesome", :content => "Asynchronous JavaScript and XML")
  end
  it 'index is successful' do
    get :index
    expect(response.status).to eq 200
  end

  it 'show is successful' do
    get :show, id: @question.id
    expect(response.status).to eq 200
  end

  it "renders the index template" do
    get :index
    expect(response).to render_template :index
  end

  it "renders the show template" do
    get :show, id: @question.id
    expect(response).to render_template :show, id: @question.id
  end

  it "routes /questions to messages#index" do
    expect(get: "/questions").to route_to(
      controller: "questions",
      action: "index"
      )
  end

  it "routes /questions/:id to messages#show" do
    expect(get: "/questions/#{@question.id}").to route_to(
      controller: "questions",
      action: "show",
      id: "#{@question.id}"
      )
  end

  after(:each) do
    @question = nil
    @answer = nil
  end
end
