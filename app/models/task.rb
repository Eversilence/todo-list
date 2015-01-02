class Task < ActiveRecord::Base
  belongs_to :project
  has_many :comments, dependent: :destroy

  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false, scope: :project_id }
  validates :name, length: { maximum: 60 }
  validates :project_id, presence: true
end
