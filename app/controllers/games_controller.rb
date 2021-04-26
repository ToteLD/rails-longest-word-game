require 'open-uri'

class GamesController < ApplicationController
  def new
    alphabet = ('A'..'Z').to_a
    @letters = 10.times.map { alphabet.sample }
  end

  def score
    @word = params[:score].upcase
    @grid = params[:letters]
    if word_in_grid?(@word, @grid) == false
      @result = "Sorry but #{@word.upcase} can't be build out of #{@grid}"
    elsif word_in_dictionnary?(@word) == false
      @result = "Sorry but #{@word.upcase} does not seem to be an english word..."
    else
      @result = "Congratulations! #{@word.upcase} is a valid english word !"
    end
  end

  private

  def word_in_grid?(word, grid)
    word.chars.all? { |letter| grid.count(letter) >= word.count(letter) }
  end

  def word_in_dictionnary?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    user_serialized = open(url).read
    dictionnary = JSON.parse(user_serialized)
    dictionnary['found']
  end
end

Net::HTTP.get(URI.parse('http://www.google.com'))
