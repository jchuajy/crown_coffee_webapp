class ChargesController < ApplicationController
      def new
            @amount = session[:orderTotal] * 100
      end
      
      def create
        @thanks = session[:orderTotal]
        # Amount in cents
        @amount = (session[:orderTotal] * 100).to_i
      
        customer = Stripe::Customer.create(
          :email => params[:stripeEmail],
          :source  => params[:stripeToken]
        )
      
        charge = Stripe::Charge.create(
          :customer    => customer.id,
          :amount      => @amount,
          :description => 'Rails Stripe customer',
          :currency    => 'sgd'
        )
      
      rescue Stripe::CardError => e
        flash[:error] = e.message
        redirect_to new_charge_path
      
      
      end
end
