# Rails.configuration.stripe = {

#   :publishable_key => Rails.application.credentials[:stripe][:stripe_test_publishable_key],
  
#   :secret_key => Rails.application.credentials[:stripe][:stripe_test_secret_key]  
# }
Stripe.api_key = Rails.application.credentials[:stripe][:stripe_test_secret_key]

Rails.application.config.filter_parameters += [:card_number, :card_expires_month, :card_expires_year, :card_cvv]
