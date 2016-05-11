require 'sinatra'
require 'httparty'
require 'json'

post '/gateway' do
  message = params[:text].gsub(params[:trigger_word], '').strip

  action, repo = message.split('_').map {|c| c.strip.downcase }
  repo_url = "https://api.github.com/repos/#{repo}"

  case action
    when 'help'
        respond_message "Usage: emojify \"<your_text>\" <emoji> [<space_emoji>]\nIf space_emoji is left omitted, blank will be used by default."
    when ''
        respond_message "Usage: emojify \"<your_text>\" <emoji> [<space_emoji>]\nIf space_emoji is left omitted, blank will be used by default."
  end
end

def respond_message message
  content_type :json
  {:text => message}.to_json
end

# script = "./emojify.sh"
# text =
# emoji =
# space =
#
# system("sh #{script} -t \"#{text}\" -e #{emoji} -s #{space}")
