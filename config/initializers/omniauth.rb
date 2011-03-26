Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'qlvIKFWOWzLweqWDpEFi1Q', 'OgWaraPr8hmOOEQFrkG7stlHp1Q5OfOxF4TfYOtw'
#  provider :facebook, 'APP_ID', 'APP_SECRET'
end
