class PlansController < ApplicationController

  before_action :require_user_customer

  def sign
    @stripe_customer = find_create_stripe_customer(current_user.customer)
    
    if require_user_customer_card(current_user.customer)
      @plan = Plan.find params[:plan_id]
      if @plan.in? current_user.customer.plans
        flash[:notice] = "User already has this plan!"
      else
        charge = create_stripe_charge(@plan.price.amount, @stripe_customer, @stripe_customer.default_source)
        if charge.start_with?('ch')
          current_user.customer.plans << @plan
          flash[:notice] = "Plan #{view_context.link_to @plan.short_name, plan_path(@plan)} added to you."
        else
          flash[:error] = "There was an error: #{charge} If you want, you can add  #{view_context.link_to "another card", customer_cards_path(current_user.customer)} to your account and try again."
        end
      end
    else
      flash[:success] = "You must add a #{view_context.link_to "card", customer_cards_path(current_user.customer)} to your account first"
    end
  end

  def cancel
    @stripe_customer = find_create_stripe_customer(current_user.customer)
    @plan = Plan.find params[:plan_id]

    unless @plan.in? current_user.customer.plans
      flash[:notice] = "User already has this plan cancelled!"
    else
      current_user.customer.plans.destroy(@plan)
      flash[:notice] = "Plan #{view_context.link_to @plan.short_name, plan_path(@plan)} was Cancelled!"
    end
  end

end
