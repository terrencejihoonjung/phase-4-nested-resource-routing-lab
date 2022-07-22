class ItemsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def index
    if params[:user_id]
      items = User.find(params[:user_id]).items
    else 
      items = Item.all
      return render json: items, include: :user
    end
    render json: items
  end

  def show
    item = Item.find(params[:id])
    render json: item
  end

  def create
    new_item = Item.create(name: params[:name], description: params[:description], price: params[:price], user_id: params[:user_id])
    render json: new_item, status: :created
  end

  private 
  
  def not_found
    render json: {error: "User not found"}, status: :not_found
  end
end
