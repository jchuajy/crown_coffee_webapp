class OrdersController < ApplicationController
      def index
            @orders = Order.all
            @current_session = request.session_options[:id]
            decoded_order = cookies[:cart].gsub "-", ","
            decoded_order = decoded_order.gsub "/", ""
            @cart_orders = JSON.parse(decoded_order)
      end
    
      def show
      end
    
      def new
      end
    
      def edit
      end
    
      def create
            old_order = Order.find_by user_id: order_params[:user_id], product_id: order_params[:product_id], variation_id: order_params[:variation_id], payment_status: "In Cart"
            
            if old_order != nil
                  old_order.quantity = order.quantity += 1
                  old_order.save
            else
                  @order = Order.new(order_params)
                  @order.save
            end

      end
    
      def update
      end
    
      def destroy
            @order = Order.find(params[:id])

            @order.update(payment_status: "Removed from cart")
            redirect_to orders_path
      end

      private
      def order_params
            params.require(:order).permit(:number, :user_id, :product_id, :quantity, :price, :payment_status, :is_complete, :variation_id)
      end


end
