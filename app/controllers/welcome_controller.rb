class WelcomeController < ApplicationController

  skip_before_action :authenticate_user!, only: [:index]

  def index
    if current_user.present?
      require_user_customer
      @plans = Plan.not_in_customer(current_user.customer)
      @avaible_plans_id = "customer_#{current_user.customer.id}_avaible_plans"
    else
      @plans = Plan.all
      @avaible_plans_id = "plans"
    end
  end

  def my_page
    @plans = Plan.by_customer(current_user.customer)
    @id_for_plans_stream_and_list = "customer_#{current_user.customer.id}_plans"
  end

end
