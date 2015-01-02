class Project < ActiveRecord::Base
has_many   :tasks, dependent: :destroy
belongs_to :user

validates :name, presence: true
validates :name, uniqueness: { case_sensitive: false, scope: :user_id }
validates :name, length: { maximum: 60 }
validates :user_id, presence: true
end
