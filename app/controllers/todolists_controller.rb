class TodolistsController < ApplicationController
  def new
  	@book = Book.new
  end

  def create
        # ストロングパラメーターを使用
         @book = Book.new(book_params)
        # DBへ保存する
        if @book.save
        flash[:notice] = "successfully"
        # トップ画面へリダイレクト
        redirect_to book_path(@book.id)
        else
        flash[:notice] = "error"
        @books = Book.all
        render action: :index
       end
    end

    def update
        @book = Book.find(params[:id])
        if @book.update(book_params)
        flash[:notice] = "successfully"
        redirect_to book_path(book.id)
         else
        flash[:notice] = "error"
        @books = Book.all
        render action: :index
    end
    end

    def index
    	@books = Book.all
        @book = Book.new
    end

    def show
    	@book = Book.find(params[:id])
    end

    def edit
        @book = Book.find(params[:id])
    end


    def destroy
        book = Book.find(params[:id]) #データ(レコード)を1件取得
        if book.destroy #データ（レコード）を削除
        flash[:notice] = "successfully"
        redirect_to books_path
        else
        flash[:notice] = "error"
        redirect_to books_path #List一覧画面へリダイレクト
    end
    end


  private

    def book_params
        params.require(:book).permit(:title, :body)
    end

end
