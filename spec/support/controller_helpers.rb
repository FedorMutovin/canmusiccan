module ControllerHelpers
  def login(user)
    @request.env['devise.mapping'] = Devise.mappings[:user]
    sign_in(user)
  end

  def blob_for(path)
    ActiveStorage::Blob.create_after_upload!(
      io: File.open(Rails.root.join(path)),
      filename: path.split('/').last
    )
  end
end
