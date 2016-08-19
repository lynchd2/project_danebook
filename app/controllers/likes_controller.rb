class LikesController < ApplicationController
  def create
    parent = params[:likeable]
    parent_id = (parent.downcase << "_id").to_sym
    @likeable = parent.classify.constantize.find(params[parent_id])
    @like = @likeable.likes.build(likes_params)
    @like.from = current_user.id
    if !Like.already_liked?(@likeable, current_user) && @like.save!  
      flash[:success] = "Liked!"
      redirect_to user_path(@likeable.user)
    else
      flash[:danger] = "You already liked that"
      redirect_to user_path(@likeable.user)
    end
  end

  def destroy
  end


  def likes_params
    params.require(:like).permit(:user_id, :from)
  end 
end
