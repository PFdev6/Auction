class CurrentBargain < ApplicationRecord
  belongs_to :user
  has_many :users
  has_many :comments, :as => :commentable, :dependent => :destroy
  belongs_to :lot
  
  after_find do
    if Time.now >= self.lot.lot_end_date && self.id_user_winner.nil?
      self.destoy
    end
  end
end
