class Comment < ActiveRecord::Base
  belongs_to :task
  has_many   :comment_attachments

  accepts_nested_attributes_for :comment_attachments
end
