class Post < ApplicationRecord
  after_save :update_post_counter
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes

  def update_post_counter
    author.update(posts_counter: Post.where(author_id: author.id).count)
  end

  def recent_comments
    comments.order(created_at: :desc).limit(3)
  end

end