class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :parent, class_name: "Comment", optional: true
  has_many :replies, class_name: "Comment", foreign_key: "parent_id", dependent: :destroy

  validates :content, presence: true

  scope :root_comments, -> { where(parent_id: nil).order(created_at: :desc).includes(:user) }
  scope :parents, -> { where(parent_id: nil) }

  def self.build_by_user(user, params)
    user.comments.build(params)
  end

  def self.find_by_user(user, id)
    user.comments.find(id)
  end
end
