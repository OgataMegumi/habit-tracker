class TaskLog < ApplicationRecord
  belongs_to :task
  validates :executed_on, presence: true
end
