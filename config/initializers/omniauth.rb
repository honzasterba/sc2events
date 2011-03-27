require 'openid/store/filesystem'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'iGs1H4w3EILBoD5X0gcw', 'hP88WIo8cfg9kzF68J2qahLrlwYMl9USlrAtuCK2Gg'
  provider :facebook, '138028809601345', 'c5ea75b4165023c1bcba913abadeac71'
  provider :google_apps, OpenID::Store::Filesystem.new('/tmp'), :domain => 'gmail.com'
  provider :open_id, OpenID::Store::Filesystem.new('/tmp')
end
