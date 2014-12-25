class Comment < ActiveRecord::Base
  belongs_to :task
  has_many   :attachments

  accepts_nested_attributes_for :attachments
end
