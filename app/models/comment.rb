class Comment < ApplicationRecord
  validates :content, presence: true

  belongs_to :author
  belongs_to :post
end
