class OhlifeImportWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(user_id, import_id)
    user = User.find(user_id)
    import = Import.find(import_id)

    OhlifeImporter.new(user, import).run
  end
end
