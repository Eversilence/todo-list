class Comment < ActiveRecord::Base
  belongs_to :task
  has_many   :attachments, dependent: :destroy

  validates :body, presence: true
  validates :body, length: { maximum: 60, minimum: 2 }
  validates :task_id, presence: true

end
