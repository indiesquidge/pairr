class Language < ActiveRecord::Base
  has_many :userlanguages, dependent: :destroy
  has_many :users, through: :userlanguages, dependent: :destroy
end
