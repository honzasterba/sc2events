require 'openid/store/filesystem'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'qlvIKFWOWzLweqWDpEFi1Q', 'OgWaraPr8hmOOEQFrkG7stlHp1Q5OfOxF4TfYOtw'
  provider :facebook, '138028809601345', 'c5ea75b4165023c1bcba913abadeac71'
  provider :google_apps, OpenID::Store::Filesystem.new('/tmp'), :domain => 'gmail.com'
  provider :open_id, OpenID::Store::Filesystem.new('/tmp')
end
