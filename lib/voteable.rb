


=begin
module Voteable

  def self.included(base)
    base.send(:include, InstanceMethods)
    base.extend ClassMethods
    base.class_eval do 
      my_class_method
    end      
  end


  module InstanceMethods
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

  module Classmethods
    def my_class_method
      has_many :votes, as: :voteable
    end
  end

end
=end