class UsersController < ApplicationController
    
    before_action :ensure_current_user, only: [:edit]

   def index
        @users = User.all
        @user = current_user
   end
   def show
        @user = User.find(params[:id])
        @books = @user.books
   end
   def edit
    @user = User.find(params[:id])
   end

   def update
     @user = User.find(params[:id])
     @user.update(user_params)
     if @user.save
        flash[:notice] = "You have updated user successfully."
        redirect_to user_path(@user.id)
     else

         render :edit
     end
   end


   private

   def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
   end
   
   def ensure_current_user
           user = User.find(params[:id])
        if user != current_user
           redirect_to user_path(current_user)
        end
   end
end

