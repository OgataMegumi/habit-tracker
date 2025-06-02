class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :tasks, dependent: :destroy
  has_many :comments, dependent: :destroy

  before_validation :set_default_name, if: -> { name.blank? }

  validates :name, presence: true

  private

  def set_default_name
    self.name = email&.split("@")&.first || "やるるさん"
  end
end
