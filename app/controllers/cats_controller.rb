class CatsController < ApplicationController
  before_action :ensure_owner, only: [:edit, :update]

  def ensure_owner
    @cat = current_user.cats.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:errors] = ["You can only edit your own cats."]
    redirect_to cats_url
  end

  def index
    @cats = current_user.cats
    render :index
  end

  def show
    @cat = Cat.find(params[:id]).includes(:rental_requests)
    @current_user = current_user
    render :show
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    @cat = Cat.new(cat_params)
    @cat.user_id = current_user[:id] if current_user
    if @cat.save
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :new
    end
  end

  def edit
    render :edit
  end

  def update
    if @cat.update_attributes(cat_params)
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :edit
    end
  end

  private

  def cat_params
    params.require(:cat)
      .permit(:age, :birth_date, :color, :description, :name, :sex)
  end
end
