RSpotify.authenticate(Rails.application.credentials[Rails.env.to_sym][:spotify][:app_id],
                      Rails.application.credentials[Rails.env.to_sym][:spotify][:app_secret])
