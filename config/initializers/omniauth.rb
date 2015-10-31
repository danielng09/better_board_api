OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '238871677031-8jicfipqr8nhvihigqqtek82dphi82bh.apps.googleusercontent.com', 'dfncMd5bRLwsYFbVVRskag3x', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end
