class CustomersController < ApplicationController

  def cards
    @customer = Customer.find params[:customer_id]
    @stripe_customer = find_create_stripe_customer(current_user.customer)

    @cards = get_stripe_customer_cards(@customer)
  end

  def create_card
    @customer = Customer.find params[:customer_id]
    @stripe_customer = find_create_stripe_customer(current_user.customer)
    token = create_card_token(card_params)
    @cards = get_stripe_customer_cards(@customer)

    if token.start_with?('tok')
      @card = create_stripe_customer_card_from_token(token, @customer)
      @stripe_customer = find_create_stripe_customer(@customer)
      @cards = get_stripe_customer_cards(@customer)
      flash[:success] = "Card #{@card.last4} added to your account"
    else
      @card = nil
      flash[:error] = token
    end
  end

  def delete_card
    @customer = Customer.find params[:customer_id]
    @card_id = params[:card_id]
    @stripe_customer = find_create_stripe_customer(@customer)
    @cards = get_stripe_customer_cards(@customer)

    if @card_id.in? @cards.map {|card| card.id }
      @card = delete_card_from_stripe_customer(@customer, @card_id)
      if @card.deleted?
        @cards = get_stripe_customer_cards(@customer)
        flash[:success] = "Success on Deleting this card!"
      else
        flash[:error] = "There was an error deleting this card. Please try again later."
      end
      
    else
      flash[:error] = "It is not possible to delete a card of another customer."
    end
  end

  def set_default_card
    @customer = Customer.find params[:customer_id]
    @card_id = params[:card_id]
    @stripe_customer = find_create_stripe_customer(@customer)
    @cards = get_stripe_customer_cards(@customer)

    if @card_id.in? @cards.map {|card| card.id }
      @stripe_customer.default_source = @card_id
      @stripe_customer.save
      flash[:success] = "Success on setting a card as default!"
    else
      flash[:error] = "It is not possible to update a card of another customer."
    end
  end

private

  def card_params
    {
      number: params[:card_number].to_s,
      exp_month: params[:card_expires_month],
      exp_year: params[:card_expires_year],
      cvv: params[:card_cvv]
    }
  end

end
