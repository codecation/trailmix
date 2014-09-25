class Import < ActiveRecord::Base
  has_many :entries
  belongs_to :user

  has_attached_file :raw_file

  validates_attachment(
    :raw_file,
    presence: true,
    content_type: { content_type: ["text/plain"] },
    size: { less_than: 2.megabytes }
  )
end
