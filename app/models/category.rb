class Category < ApplicationRecord
  belongs_to :user
  has_many :products, dependent: :destroy

  extend FriendlyId
  friendly_id :name, use: :slugged

  validates_presence_of :name
  validates_presence_of :description
end