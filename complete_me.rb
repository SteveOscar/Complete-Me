require 'pry'

class CompleteMe
  attr_accessor :children, :flag, :letter, :word

  def initialize(value = nil)
    @children = {}
    @flag = false
    @word = word
  end

  def add_letter(letter)
    val = word ? word + letter : letter
    children[letter] = CompleteMe.new(val)
  end

  def insert(string)
    node = self
    string.each_char do |letter|
      node.add_letter(letter) unless node.children.has_key?(letter)
      node = node.children[letter]
    end
    @flag = true
  end


end
