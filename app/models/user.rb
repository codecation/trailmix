class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable

  has_many :entries
  has_many :imports

  def newest_entry
    entries.last
  end

  def random_entry
    entries.sample
  end
end
