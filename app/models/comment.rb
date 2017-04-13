class Comment < ApplicationRecord

  belongs_to :user
  belongs_to :image

  validates :body, presence: true, length: { maximum: 140 }

  after_create_commit { CommentBroadcastJob.perform_later(self) }
end
