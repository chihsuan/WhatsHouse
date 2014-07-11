Rails.application.config.middleware.use OmniAuth::Builder do
	provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_SECRET'], :client_options => {:ssl => {:ca_path => '/etc/ssl/certs'}}
end

