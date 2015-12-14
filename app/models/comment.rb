class Comment < ActiveRecord::Base
  belongs_to :creator, foreign_key: "user_id", class_name: "User"
  belongs_to :post
  validates :body, presence: true
  has_many :votes, as: :voteable

  def total_votes
    self.vote_up - self.vote_down
  end

  def vote_up
    self.votes.where(vote: true).size
  end
  
  def vote_down
    self.votes.where(vote: false).size
  end

end