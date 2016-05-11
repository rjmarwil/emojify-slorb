require 'sinatra'
require 'httparty'
require 'json'

post '/gateway' do
  message = params[:text].gsub(params[:trigger_word], '').strip

  case action
  when 'help'
    respond_message "Usage: emojify \"<your_text>\" <emoji>"
    respond_message "Surround <your_text> with quotes"
  when ''
    respond_message "Usage: emojify \"<your_text>\" <emoji>"
    respond_message "Surround <your_text> with quotes"
  else
    script = "./emojify.sh"
    text = message.split(' ')[0...-1].join(' ')
    emoji = message.split.last
    emoji_text = shell_script(script, text, emoji)
    respond_message "#{emoji_text}"
  end
end

def respond_message message
  content_type :json
  {:text => message}.to_json
end

def shell_script(script, text, emoji)
  system("sh #{script} -t \"#{text}\" -e #{emoji}")
end
