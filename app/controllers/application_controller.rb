class ApplicationController < ActionController::Base

  before_action :authenticate_user!


  def require_plan
    unless current_user.customer.plans.any?
      flash[:notice] = "You have to purchase a plan in order to access this page!"
      redirect_to root_path
    end
  end

  # Brief comment: 
  # What is happening below is that, when it happens to a new user customer having no stripe_id,
  # for development purposes, it will retrieve the stripe_customer with the same email and assign
  # it to the database customer. This was created to assure that no aditional stripe_customers
  # being created, avoiding duplicates. I know that this is not the best approach to assuring that,
  # but since it is only for studies and learnign how the API works, I realy don't care ¯\_(ツ)_/¯
  # Any tips, please reffer to me :)

  def create_atach_stripe_customer(customer, description = "")
    if customer.stripe_id.nil?
      stripe_customer = get_stripe_user_by_email(customer.email)
      unless stripe_customer
        stripe_customer = Stripe::Customer.create({
          description: description,
          email: customer.email
        })
      end
      customer.update stripe_id: stripe_customer.id
    end
  end

  def get_stripe_user_by_email(email)
    Stripe::Customer.search({
      query: "email: '#{email}'"
    }).first
  end

  def find_create_stripe_customer(customer)
    create_atach_stripe_customer(customer)
    Stripe::Customer.retrieve(customer.stripe_id)
  end

  def require_user_customer(user = current_user)
    user.customer = Customer.create unless user.customer.present?
    find_create_stripe_customer user.customer
  end

  def require_user_customer_card(customer)
    get_stripe_customer_cards(customer).count > 0
  end

  def get_stripe_customer_cards(customer)
    cards = []
    begin
      cards = Stripe::Customer.list_sources(
        customer.stripe_id,
        {object: 'card'}
      )
    rescue => exception
      exception
    end
    return cards
  end

  def create_card_token(params)
    token = ""
    begin
      token = Stripe::Token.create( {
        card: {
          number: params[:number].to_s, 
          exp_month: params[:exp_month],
          exp_year: params[:exp_year],
          cvc: params[:cvc]
        }
      }).id
    rescue => e
      token = e.message
    end
    return token
  end

  def set_default_card_to_stripe_customer(customer, card)
    Stripe::Customer.update(
      customer.stripe_id,
      default_source: card.id,
    )
  end

  def delete_card_from_stripe_customer(customer, card_id) 
    Stripe::Customer.delete_source(
      customer.stripe_id,
      card_id,
    )
  end

  def create_stripe_customer_card_from_token(token_id, customer)
    Stripe::Customer.create_source(customer.stripe_id, { source: token_id })
  end

  def create_stripe_customer_card(params, customer)
    token = create_card_token(params)
    Stripe::Customer.create_source(customer._stripe_id, { source: token_id })
  end

  def create_stripe_charge(amount_to_be_paid, stripe_customer, card_id=nil)
    charge = ""
    card_id = stripe_customer.default_source if card_id.nil?
    begin 
    charge = Stripe::Charge.create({
        amount: amount_to_be_paid, 
        currency: 'brl',
        source: card_id,
        customer: stripe_customer.id,
        description: "Amount #{amount_to_be_paid} charged!"
      })
    charge = charge.id
    rescue => e
      charge = e.message
    end
    return charge
  end
end

# tok_radarBlock
# tok_riskLevelHighest
# tok_riskLevelElevated
# tok_cvcCheckFail
# tok_avsZipFail
# tok_avsLine1Fail
# tok_avsFail
# tok_avsUnchecked
