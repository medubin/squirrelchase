class Api::HighscoresController < ApplicationController

  def index
  end

  def create
    @highscore = HighScore.new(highscore_params)

    if @highscore.save
      redirect_to root_url
    end
  end



  private
  def highscore_params
    params.require(:highscore).permit(:score, :name)
  end
end
