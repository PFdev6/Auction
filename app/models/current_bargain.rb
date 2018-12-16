class CurrentBargain < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  belongs_to :user
  has_many :users
  has_many :comments, :as => :commentable, :dependent => :destroy
  belongs_to :lot
  
  
  after_find do
    if Time.now >= self.lot.lot_end_date && self.id_user_winner.nil?
      self.lot.isplayedout = false;
      self.destroy
    end
  end
end
