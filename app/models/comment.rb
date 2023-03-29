class Comment < ApplicationRecord
  after_save :update_comment_count
  belongs_to :author, class_name: 'User'
  belongs_to :post

  def update_comment_count
    post.update(comment_count: Comment.where(post_id: post_id).count)
  end
end