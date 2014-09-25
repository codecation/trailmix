require 'rails_helper'

describe Import do
  it { should have_attached_file(:raw_file) }
  it { should validate_attachment_content_type(:raw_file).
       allowing('text/plain') }
  it { should validate_attachment_size(:raw_file).
       less_than(2.megabytes) }

  it { should have_many(:entries) }
  it { should belong_to(:user) }
end
