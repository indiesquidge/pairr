class User < ActiveRecord::Base
  has_many :userlanguages, dependent: :destroy
  has_many :languages, through: :userlanguages, dependent: :destroy

  def self.find_or_create_from_auth(data)
    user = User.find_or_initialize_by(provider: data.provider, uid: data.uid)

    user.login      = data.extra.raw_info.login
    user.avatar_url = data.extra.raw_info.avatar_url
    user.token      = data.credentials.token
    user.save

    user
  end
end
