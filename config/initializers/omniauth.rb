Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook,  Rails.application.secrets.app_id, Rails.application.secrets.app_secret
          # ,callback_url: Rails.application.secrets.callback_url
end