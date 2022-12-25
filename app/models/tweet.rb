class Tweet < ApplicationRecord
  belongs_to :user
  validates :user, presence: true
  validates :message, presense: true, length: { maximum: 140}
  
end
