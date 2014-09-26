require 'rails_helper'

describe Import do
  it { should have_many(:entries) }
  it { should belong_to(:user) }
end
