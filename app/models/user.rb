class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable

  has_many :entries, dependent: :destroy
  has_many :imports, dependent: :destroy

  def newest_entry
    entries.last
  end

  def random_entry
    entries.sample
  end

  def in_time_zone(time)
    time.in_time_zone time_zone
  end
end
