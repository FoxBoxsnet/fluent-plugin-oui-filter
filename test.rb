s = "60:92:1a:ab:cd:ef"
s.gsub!(/[0-9a-fA-F:]{1,8}$/, '')
s.gsub!(/:/, '')
s = s.upcase
puts s