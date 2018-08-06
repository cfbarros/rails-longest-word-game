require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    array = Array("A".."Z")
    @new = array.sample(9)

  end

  def score
    @try = params["try"]
    @new = params["new"]
    url = "https://wagon-dictionary.herokuapp.com/#{@try}"
    try_serialized = open(url).read
    try = JSON.parse(try_serialized)

    # raise

    if try["found"] == false
      @score = "Sorry but #{@try.upcase} does not seem to be a valid english word"
    elsif @try.upcase.split("").sort == (@try.upcase.split("") & @new.split("")).sort
      @score = "Congratulations, #{@try.upcase} is a valid English word!"
    else
      @score = "Sorry, but #{@try.upcase} cannot be build out of #{@new.split.join(", ")} "
    end
  end
end
