class Attachment < ActiveRecord::Base
  before_destroy :destroy_file

  belongs_to :comment
  mount_uploader :file, FileUploader

  validates :comment_id, presence: true

  private

  def destroy_file
    self.remove_file!
    self.save
  end
end
