class HighScore < ActiveRecord::Base
  validates :name, :score, presence: true
  validates :name, length: {maximum: 12}


  def self.top_ten
    HighScore.all.order(score: :desc).limit(10)
  end

  def self.daily_five
    HighScore.where('created_at BETWEEN ? AND ?', DateTime.now.beginning_of_day, DateTime.now.end_of_day).limit(5)
  end
end
