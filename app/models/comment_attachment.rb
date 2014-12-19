class CommentAttachment < ActiveRecord::Base
  belongs_to :comment
  mount_uploader :avatar, AvatarUploader

end
