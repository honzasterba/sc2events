require 'openid/store/filesystem'
require 'omniauth/strategies/facebook'
require 'omniauth/strategies/twitter'
require 'omniauth/strategies/open_id'
require 'omniauth/strategies/google_apps'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'tImv9eyaYOFRUSNpEjYMg', 'OLAoubaWuPrrVLoOuuBn2Nikjkp0QdQbbQAyxny4Svg'
  provider :facebook, '138028809601345', 'c5ea75b4165023c1bcba913abadeac71'
  provider :google_apps, OpenID::Store::Filesystem.new('/tmp'), :domain => 'gmail.com'
  provider :open_id, OpenID::Store::Filesystem.new('/tmp')
end
