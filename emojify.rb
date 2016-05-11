require 'sinatra'
require 'httparty'
require 'json'
require 'shellwords'

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
    emoji_text = bash("#{script} -t #{text} -e #{emoji}")
    respond_message "#{emoji_text}"
  end
end

def respond_message message
  content_type :json
  {:text => message}.to_json
end

def bash(command)
  escaped_command = Shellwords.escape(command)
  system "bash -c #{escaped_command}"
end
