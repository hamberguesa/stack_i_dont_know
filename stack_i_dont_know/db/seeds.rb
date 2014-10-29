a = Question.create(:title => "What is AJAX?", :content => "AJAX for what?")
b = Question.create(:title => "What is Ruby?", :content => "I don't get it.")
c = Question.create(:title => "Where should I go to programming school?", :content => "DBC, HackReactor or Hackbright?")


a.answers.create(:title => "AJAX is awesome", :content => "Asynchronous JavaScript and XML")
b.answers.create(:title => "Ruby is awesome", :content => "It's a programming language.")
c.answers.create(:title => "DBC", :content => "Because I went there and it's #awesome")

