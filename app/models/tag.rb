class Tag < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, uniqueness: {scope: :user}

  has_many :tag_contents, dependent: :destroy
  has_many :contents, through: :tag_contents
end
