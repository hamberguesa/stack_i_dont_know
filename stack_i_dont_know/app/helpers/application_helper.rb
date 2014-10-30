module ApplicationHelper
  def get_quote
    headers = {"User-Agent" => "Httparty"}
    basic_auth = {username: ENV["GITHUB_USERNAME"] , password: ENV["GITHUB_PW"]}
    HTTParty.get('https://api.github.com/zen', headers: headers, basic_auth: basic_auth).body
  end
end
