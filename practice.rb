def display_info_request
  puts "Enter your name and press ENTER:"
end

def get_user_info
  display_info_request
  gets
end

def say_hello
  puts "Hello, " + get_user_info
end

say_hello
