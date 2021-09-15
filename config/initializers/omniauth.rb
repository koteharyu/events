Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.env.development? || Rails.env.test?
    provider :github, "49d0130e311077e5dae6", "bcb87f5c18a6f2a788bed7bb44a5c64f7715cd7e"
  else
    provider :github
      Rails.application.credentials.github[:client_id]
      Rails.application.credentials.github[:client_secret]
  end
end
