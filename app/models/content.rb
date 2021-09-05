class Content < ApplicationRecord
  belongs_to :user

  validates :title,  presence: true
  has_many :tag_contents, dependent: :destroy
  has_many :tags, through: :tag_contents
  has_rich_text :description
end
