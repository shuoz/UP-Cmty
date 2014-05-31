class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  validates :content, length: {within: 1..100}
end
