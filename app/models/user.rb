class User < ApplicationRecord
  has_many :posts

  def self.from_omniauth(auth)
    where(auth.permit(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user. avatar = auth.info.image
      user.save!
    end
  end
end
