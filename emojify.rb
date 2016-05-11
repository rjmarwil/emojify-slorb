#!/usr/bin/env ruby

script = "./emojify.sh"
text =
emoji =
space = 

system("sh #{script} -t \"#{text}\" -e #{emoji} -s #{space}")
