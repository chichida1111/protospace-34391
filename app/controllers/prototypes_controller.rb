class PrototypesController < ApplicationController
  before_action :set_prototype, only: [:edit, :show]
  before_action :authenticate_user!, except: [:show, :index,]
  #before_action :move_to_index, except: [:index, :new, :show, :create]

  
  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end
  
  def index
    @prototypes = Prototype.all
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments
  end
  
  def edit
    unless @prototype.user_id == current_user.id
      redirect_to root_path
    end
  end

  def update
    prototype = Prototype.find(params[:id])
    if prototype.update(prototype_params)
      redirect_to prototype_path(prototype.id), method: :get
    else
      render :edit
    end
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.create(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render new_prototype_path
    end
  end

  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

end
