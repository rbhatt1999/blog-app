class Comment < ApplicationRecord
  after_save :update_comment_count
  belongs_to :author, class_name: 'User'
  belongs_to :post

  def update_comment_count
    post.update(comments_counter: Comment.where(post_id:).count)
  end
end
