#!/usr/bin/ruby
require 'sinatra'
require 'httparty'
require 'json'

post '/gateway' do
  message = params[:text].gsub(params[:trigger_word], '').strip

  case message
    when 'help'
      respond_message "Usage: emojify \"<your_text>\" <emoji>"
      respond_message "Surround <your_text> with quotes"
    when ''
      respond_message "Usage: emojify \"<your_text>\" <emoji>"
      respond_message "Surround <your_text> with quotes"
    else
      respond_message "#{final}"
  end

  script = "./emojify.sh"
  text = message.split(' ')[0...-1].join(' ').downcase.gsub('"','').gsub('"','')
  emoji = message.split.last.downcase
  color=":#{emoji}:"
  space=":blank:"
  pretext=""

  alphabet = Hash.new
  alphabet["a"]="#{space}#{color}#{space}#{space}\n#{color}#{space}#{color}#{space}\n#{color}#{color}#{color}#{space}\n#{color}#{space}#{color}#{space}\n#{color}#{space}#{color}#{space}"
  alphabet["b"]="#{color}#{color}#{color}#{space}#{space}\n#{color}#{space}#{space}#{color}#{space}\n#{color}#{color}#{color}#{space}#{space}\n#{color}#{space}#{space}#{color}#{space}\n#{color}#{color}#{color}#{space}#{space}"
  alphabet["c"]="#{color}#{color}#{color}#{space}\n#{color}#{space}#{space}#{space}\n#{color}#{space}#{space}#{space}\n#{color}#{space}#{space}#{space}\n#{color}#{color}#{color}#{space}"
  alphabet["d"]="#{color}#{color}#{color}#{space}#{space}\n#{color}#{space}#{space}#{color}#{space}\n#{color}#{space}#{space}#{color}#{space}\n#{color}#{space}#{space}#{color}#{space}\n#{color}#{color}#{color}#{space}#{space}"
  alphabet["e"]="#{color}#{color}#{color}#{space}\n#{color}#{space}#{space}#{space}\n#{color}#{color}#{color}#{space}\n#{color}#{space}#{space}#{space}\n#{color}#{color}#{color}#{space}"
  alphabet["f"]="#{color}#{color}#{color}#{space}\n#{color}#{space}#{space}#{space}\n#{color}#{color}#{space}#{space}\n#{color}#{space}#{space}#{space}\n#{color}#{space}#{space}#{space}"
  alphabet["g"]="#{color}#{color}#{color}#{space}#{space}\n#{color}#{space}#{space}#{space}#{space}\n#{color}#{space}#{color}#{color}#{space}\n#{color}#{space}#{space}#{color}#{space}\n#{color}#{color}#{color}#{color}#{space}"
  alphabet["h"]="#{color}#{space}#{color}#{space}\n#{color}#{space}#{color}#{space}\n#{color}#{color}#{color}#{space}\n#{color}#{space}#{color}#{space}\n#{color}#{space}#{color}#{space}"
  alphabet["i"]="#{color}#{color}#{color}#{space}\n#{space}#{color}#{space}#{space}\n#{space}#{color}#{space}#{space}\n#{space}#{color}#{space}#{space}\n#{color}#{color}#{color}#{space}"
  alphabet["j"]="#{space}#{space}#{color}#{space}\n#{space}#{space}#{color}#{space}\n#{space}#{space}#{color}#{space}\n#{color}#{space}#{color}#{space}\n#{space}#{color}#{space}#{space}"
  alphabet["k"]="#{color}#{space}#{space}#{color}#{space}\n#{color}#{space}#{color}#{space}#{space}\n#{color}#{color}#{space}#{space}#{space}\n#{color}#{space}#{color}#{space}#{space}\n#{color}#{space}#{space}#{color}#{space}"
  alphabet["l"]="#{color}#{space}#{space}#{space}\n#{color}#{space}#{space}#{space}\n#{color}#{space}#{space}#{space}\n#{color}#{space}#{space}#{space}\n#{color}#{color}#{color}#{space}"
  alphabet["m"]="#{color}#{space}#{space}#{space}#{color}#{space}\n#{color}#{color}#{space}#{color}#{color}#{space}\n#{color}#{space}#{color}#{space}#{color}#{space}\n#{color}#{space}#{space}#{space}#{color}#{space}\n#{color}#{space}#{space}#{space}#{color}#{space}"
  alphabet["n"]="#{color}#{space}#{space}#{color}#{space}\n#{color}#{color}#{space}#{color}#{space}\n#{color}#{space}#{color}#{color}#{space}\n#{color}#{space}#{space}#{color}#{space}\n#{color}#{space}#{space}#{color}#{space}"
  alphabet["o"]="#{color}#{color}#{color}#{space}\n#{color}#{space}#{color}#{space}\n#{color}#{space}#{color}#{space}\n#{color}#{space}#{color}#{space}\n#{color}#{color}#{color}#{space}"
  alphabet["p"]="#{color}#{color}#{color}#{space}\n#{color}#{space}#{color}#{space}\n#{color}#{color}#{color}#{space}\n#{color}#{space}#{space}#{space}\n#{color}#{space}#{space}#{space}"
  alphabet["q"]="#{color}#{color}#{color}#{space}#{space}\n#{color}#{space}#{color}#{space}#{space}\n#{color}#{space}#{color}#{space}#{space}\n#{color}#{color}#{color}#{space}#{space}\n#{space}#{space}#{color}#{color}#{space}"
  alphabet["r"]="#{color}#{color}#{color}#{space}#{space}\n#{color}#{space}#{space}#{color}#{space}\n#{color}#{color}#{color}#{space}#{space}\n#{color}#{space}#{color}#{space}#{space}\n#{color}#{space}#{space}#{color}#{space}"
  alphabet["s"]="#{color}#{color}#{color}#{space}\n#{color}#{space}#{space}#{space}\n#{color}#{color}#{color}#{space}\n#{space}#{space}#{color}#{space}\n#{color}#{color}#{color}#{space}"
  alphabet["t"]="#{color}#{color}#{color}#{space}\n#{space}#{color}#{space}#{space}\n#{space}#{color}#{space}#{space}\n#{space}#{color}#{space}#{space}\n#{space}#{color}#{space}#{space}"
  alphabet["u"]="#{color}#{space}#{color}#{space}\n#{color}#{space}#{color}#{space}\n#{color}#{space}#{color}#{space}\n#{color}#{space}#{color}#{space}\n#{color}#{color}#{color}#{space}"
  alphabet["v"]="#{color}#{space}#{color}#{space}\n#{color}#{space}#{color}#{space}\n#{color}#{space}#{color}#{space}\n#{color}#{space}#{color}#{space}\n#{space}#{color}#{space}#{space}"
  alphabet["w"]="#{color}#{space}#{space}#{space}#{color}#{space}\n#{color}#{space}#{space}#{space}#{color}#{space}\n#{color}#{space}#{color}#{space}#{color}#{space}\n#{color}#{color}#{space}#{color}#{color}#{space}\n#{color}#{space}#{space}#{space}#{color}#{space}"
  alphabet["x"]="#{color}#{space}#{space}#{space}#{color}#{space}\n#{space}#{color}#{space}#{color}#{space}#{space}\n#{space}#{space}#{color}#{space}#{space}#{space}\n#{space}#{color}#{space}#{color}#{space}#{space}\n#{color}#{space}#{space}#{space}#{color}#{space}"
  alphabet["y"]="#{color}#{space}#{space}#{space}#{color}#{space}\n#{space}#{color}#{space}#{color}#{space}#{space}\n#{space}#{space}#{color}#{space}#{space}#{space}\n#{space}#{space}#{color}#{space}#{space}#{space}\n#{space}#{space}#{color}#{space}#{space}#{space}"
  alphabet["z"]="#{color}#{color}#{color}#{space}\n#{space}#{space}#{color}#{space}\n#{space}#{color}#{space}#{space}\n#{color}#{space}#{space}#{space}\n#{color}#{color}#{color}#{space}"
  alphabet["."]="#{space}#{space}\n#{space}#{space}\n#{space}#{space}\n#{space}#{space}\n#{color}#{space}"
  alphabet[","]="#{space}#{space}#{space}\n#{space}#{space}#{space}\n#{space}#{space}#{space}\n#{space}#{color}#{space}\n#{color}#{space}#{space}"
  alphabet["'"]="#{color}#{space}\n#{color}#{space}\n#{space}#{space}\n#{space}#{space}\n#{space}#{space}"
  alphabet["!"]="#{color}#{space}\n#{color}#{space}\n#{color}#{space}\n#{space}#{space}\n#{color}#{space}"
  alphabet[" "]="#{space}\n#{space}\n#{space}\n#{space}\n#{space}"

  (0..(text.length-1)).each do |i|
    pretext << "#{alphabet["#{text[i]}"]}\n"
  end

  line1=""
  line2=""
  line3=""
  line4=""
  line5=""
  counter=1

  while counter < (pretext.lines.count + 1) do
    if ((counter - 1) % 5) == 0
      line1 += pretext.lines[counter-1].gsub("\n", '')
      counter+=1
    elsif ((counter - 2) % 5) == 0
      line2 += pretext.lines[counter-1].gsub("\n", '')
      counter+=1
    elsif ((counter - 3) % 5) == 0
      line3 += pretext.lines[counter-1].gsub("\n", '')
      counter+=1
    elsif ((counter - 4) % 5) == 0
      line4 += pretext.lines[counter-1].gsub("\n", '')
      counter+=1
    elsif ((counter - 5) % 5) == 0
      line5 += pretext.lines[counter-1].gsub("\n", '')
      counter+=1
    else
      echo "Something's fucked ¯\\_(ツ)_/¯"
      fi
    end
  end

  final = "#{line1}\n#{line2}\n#{line3}\n#{line4}\n#{line5}\n"
end

def respond_message message
  content_type :json
  {:text => message}.to_json
end
