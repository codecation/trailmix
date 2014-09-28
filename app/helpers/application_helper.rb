module ApplicationHelper
  def in_user_time_zone(time)
    user_signed_in? ? time.in_time_zone(current_user.time_zone) : time
  end
end
