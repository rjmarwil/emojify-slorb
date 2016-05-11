require 'sinatra'
require 'httparty'
require 'json'

post '/gateway' do
  message = params[:text].gsub(params[:trigger_word], '').strip
  script = "./emojify.sh"
  text = message.split(' ')[0...-1].join(' ')
  emoji = message.split.last

  case action
  when 'help'
    respond_message "Usage: emojify \"<your_text>\" <emoji>"
    respond_message "Surround <your_text> with quotes"
  when ''
    respond_message "Usage: emojify \"<your_text>\" <emoji>"
    respond_message "Surround <your_text> with quotes"
  when not(text.isblank) && not(emoji.isblank)
    shell_script(script, text, emoji)
  end
end

def respond_message message
  content_type :json
  {:text => message}.to_json
end

def shell_script script text emoji
  system("sh #{script} -t \"#{text}\" -e #{emoji}")
end
