class Task < ActiveRecord::Base
  belongs_to :project
  acts_as_list scope: :project
  has_many :comments, dependent: :destroy

  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false, scope: :project_id }
  validates :name, length: { maximum: 60, minimum: 5 }
  validates :project_id, presence: true
end
