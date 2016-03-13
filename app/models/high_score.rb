class HighScore < ActiveRecord::Base
  validates :name, :score, presence: true
  validates :name, length: {maximum: 12}


  def self.top_five
    HighScore.all.order(score: :desc).limit(5)
  end
end
