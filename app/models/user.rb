class User < ApplicationRecord
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "300x300>" }, default_url: ":style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  validates :nickname, :email, :first_name, :second_name, presence: true   
  devise :confirmable, :database_authenticatable, :omniauthable, :recoverable, :rememberable, :registerable, :trackable, :validatable
  has_many :lots, dependent: :destroy
  has_many :main_news, dependent: :destroy
  has_many :messages, dependent: :destroy


  def self.from_omniauth(auth)
    user = self.where(provider: auth.provider, uid: auth.uid).first
    
    if user.present?
      user 
    else
      user_with_email = self.find_by_email(auth.info.email)
      if user_with_email.present?
        user = user_with_email
      else
        user = self.new
        case auth.provider 
          when 'facebook'
            user.provider = auth.provider
            user.uid = auth.uid
            user.email = auth.info.email
            user.nickname = auth.info.name + rand(1..10000).to_s
            user.password = Devise.friendly_token[0,20]
            user.first_name = auth.info.name.split(' ')[0]
            user.second_name = auth.info.name.split(' ')[1]
          when 'github'
            user.provider = auth.provider
            user.uid = auth.uid
            user.email = auth.info.email
            user.nickname = auth.info.name + rand(1..10000).to_s
            user.password = Devise.friendly_token[0,20]
            user.first_name = ''
            user.second_name = ''
        end
        user.save
      end
    end
    return user
  end 

end
