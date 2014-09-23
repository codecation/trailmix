class PromptTask
  def initialize(users, worker)
    @users = users
    @worker = worker
  end

  def run
    @users.each do |user|
      @worker.perform_async(user.id)
    end
  end
end
