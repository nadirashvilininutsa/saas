# if Rails.env.production?
#   # In production, use a domain-wide cookie for subdomains
#   Rails.application.config.session_store :cookie_store, key: 'ninutsa-saas-app-b19faaa27c0d.herokuapp.com', domain: :all, tld_length: 2
# else
#   # In development, use the default domain (localhost)
#   Rails.application.config.session_store :cookie_store, key: '_ninutsa_saas_session', domain: :all
# end


# if Rails.env.production?
#   # Production environment configuration
#   Rails.application.config.session_store :cookie_store, key: '_ninutsa_sass_session', domain: :all, tld_length: 3, secure: true
# else
#   # Development environment configuration
#   Rails.application.config.session_store :cookie_store, key: '_ninutsa_sass_session', domain: :all
# end

# Rails.application.config.session_store :cookie_store, key: '_myapp_session', domain: { 
#   production: '.herokuapp.com', 
#   development: 'localhost', 
#   test: 'localhost' 
# }.fetch(Rails.env.to_sym, :all)
