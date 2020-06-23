class BooksController < ApplicationController
	before_action :authenticate_user!

	def create
		@nbook = Book.new(book_params)
		@nbook.user_id = current_user.id
		if @nbook.save
			flash[:notice] = "You have creatad book successfully."
			redirect_to "/books/#{@nbook.id}"
		else
			@books = Book.all
			render "index"
		end
	end

	def index
		@nbook = Book.new
		@books = Book.all
	end

	def show
		@nbook = Book.new
		@book = Book.find(params[:id])
	end

	def edit
		@book = Book.find(params[:id])
		if @book.user_id != current_user.id
			redirect_to books_path
		else
		end
	end

    def update
        @book = Book.find(params[:id])
        if @book.update(book_params)
            flash[:notice] = "You have updated book successfully."
            redirect_to book_path(@book.id)
        else
            render "edit"
        end
    end

    def destroy
        book = Book.find(params[:id])
        book.destroy
        flash[:notice] = "Book was successfully destroyed."
        redirect_to books_path
    end



	private

    def book_params
        params.require(:book).permit(:title, :body)
    end
end
