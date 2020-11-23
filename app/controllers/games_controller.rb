require "open-uri"
class GamesController < ApplicationController
  def english_words?(word)
    request = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(request.read)
    json["found"]
  end

  def new
    @letters = []
    10.times do
      @letters << ('a'..'z').to_a.sample
    end
  end

  def score
    @letters = params[:letters].split
    @word = params[:word]
    if word_can_be_made_from_letters? && english_words?(@word)
      @answer = "Congratulations! #{@word} is a valid English word!"
    elsif english_words?(@word)
      @answer = "Sorry but TEST can't be built out of #{@letters}"
    else
      @answer = "Sorry but #{@word} does not seem to be valid English word..."
    end
  end

  def word_can_be_made_from_letters?
    @word.chars.all? { |letter| @letters.include?(letter) }
  end
end





