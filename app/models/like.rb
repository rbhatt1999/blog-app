class Like < ApplicationRecord
  after_save :update_like_count
  belongs_to :author, class_name: 'User'
  belongs_to :post

  def update_like_count
    post.update(like_count: Like.where(post_id: post_id).count)
  end
end