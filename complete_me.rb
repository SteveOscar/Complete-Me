require 'pry'
class CompleteMe
  attr_accessor :children, :is_word, :word, :weighted_suggestions

  def initialize(word = nil, is_word = false)
    @children = {}
    @is_word = is_word
    @word = word
  end

  def add_letter(letter, string)
    val = word ? word + letter : letter
    if val == string
      children[letter] = CompleteMe.new(val, true)
    else
      children[letter] = CompleteMe.new(val)
    end
  end

  def insert(string)
    node = self
    string.each_char do |letter|
      node.add_letter(letter, string) unless node.children.has_key?(letter)
      node = node.children[letter]
    end
  end

  def populate(text)
    words = text.split("\n")
    words.each { |word| insert(word)}
  end

  def count
    if children.empty?
      is_word ? 1 : 0
    else
      elements = children.map do |letter, child_trie|
        child_trie.count
      end
      elements.reduce(:+) + (is_word ? 1 : 0)
    end
  end

  def suggestion_weighting(suggestions)
    weighted = (Hash[suggestions.map {|x| [x, 0]}]).sort_by { |k, v| -v }
    print weighted.map { |k, v| k }
    binding.pry
    weighted.sort_by { |k, v| -v }
    puts weighted.keys
    puts "Please select a word..."
    selection = gets.chomp
    weighted[selection] += 1
    binding.pry
  end


  def auto_suggest(prefix)
    node = self
    prefix.each_char do |letter|
      return unless node.children.has_key?(letter) #removed Set.new after return
      node = node.children[letter]
    end
    answer = node.retrieve_endings
    suggestion_weighting(answer)
  end

  def retrieve_endings
    if children.empty?
      word if is_word
    else
      endings = children.map do |letter, child_trie|
        child_trie.retrieve_endings
      end
      endings << word if is_word
      return endings.flatten
    end
  end

  ## add tests that RaiseError

end
