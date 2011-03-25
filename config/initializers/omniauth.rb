Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'Gu7ak0g5CIKGGF2jaRcKg', 'YWamg6YRBzsSxNAQ9jWAYiSh6ziBYjzmcvzPCLDQ'
#  provider :facebook, 'APP_ID', 'APP_SECRET'
end
