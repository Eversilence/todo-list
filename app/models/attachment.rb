class Attachment < ActiveRecord::Base
  belongs_to :comment
  mount_uploader :file, FileUploader

  validates :file, presence: true
  validates :comment_id, presence: true
end
