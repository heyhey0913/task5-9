class UsersController < ApplicationController
		before_action :authenticate_user!

	def index
		@nbook = Book.new
		@users = User.all
	end

	def show
		@nbook = Book.new
		@user = User.find(params[:id])
		@books = @user.books
	end

	def edit
        @user = User.find(params[:id])
        if @user.id != current_user.id
			redirect_to user_path(current_user)
		end
    end

    def update
		@user = User.find(params[:id])
		if @user.update(user_params)
			flash[:notice] = "You have updated user successfully."
			redirect_to user_path(@user.id)
		else
			render "edit"
		end
	end

	private

    def user_params
        params.require(:user).permit(:name, :introduction ,:profile_image)
    end
end
