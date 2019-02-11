class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  attr_accessor :word
  
  def guesses
    @guesses.to_s
  end
  
  def guesses=(str)
    @guesses = str
  end
    
  
  def wrong_guesses
    @wrong_guesses.to_s
  end
  
  def wrong_guesses=(str)
    @wrong_guesses = str
  end
  
  
  def initialize(word)
    @word = word.downcase
    @guesses = ''
    @wrong_guesses = ''
  end

  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end
  
  def guess(str)
    str = str.downcase
    if str == nil
      raise ArgumentError
    elsif str == ''
      raise ArgumentError
    elsif (str !=~ /[A-Za-z]/) == 0
      raise ArgumentError
    elsif @word.count(str) == 0
      valid = does_contain?(@wrong_guesses, str)
      @wrong_guesses = add_if_does_not_contain(@wrong_guesses, str)
      return !valid
    else
      valid = does_contain?(@guesses, str)
      @guesses = add_if_does_not_contain(@guesses, str)
      return !valid
    end
  end
  
  def does_contain?(str, letter)
    if str == nil
      return false
    elsif str.count(letter) > 0
      return true
    else
      return false
    end
  end
  
  
  def add_if_does_not_contain(str, letter)
    if str == nil
      return letter
    elsif str.count(letter) > 0
      return str
    else
      return str + letter
    end
  end

end
