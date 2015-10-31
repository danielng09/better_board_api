Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '952248599209-9bpduhjcm1ev2cjsjfedlisdcu1sftml.apps.googleusercontent.com', 'paP0U1HZSbV6GQbpRLjMFhn7', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end
