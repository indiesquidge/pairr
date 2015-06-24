class Language < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  has_many :userlanguages, dependent: :destroy
  has_many :users, through: :userlanguages, dependent: :destroy
end
