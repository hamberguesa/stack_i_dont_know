module ApplicationHelper
  def get_quote
    headers = {"User-Agent" => "#{ENV["USER_AGENT"]}", "Authorization" => "Token #{ENV["KEY"]}"}

    HTTParty.get('https://api.github.com/zen', headers: headers ).body
  end

end
