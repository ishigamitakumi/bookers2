class BooksController < ApplicationController

  before_action :correct_user, only: [:edit, :update]

  def index
    @books = Book.all
    @user = current_user
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @newbook = Book.new
  end

  def create
    # １.&2. データを受け取り新規登録するためのインスタンス作成
    @book = Book.new(book_params)

    @book.user_id = current_user.id
    # 3. データをデータベースに保存するためのsaveメソッド実行

     if @book.save
      redirect_to book_path(@book.id) , notice: 'Book was successfully created.'
     else
      @books = Book.all
      @user = current_user
      render 'index'
     end

  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])

    if @book.update(book_params)
      redirect_to book_path(@book.id) , notice: 'Book was successfully updated.'
    else
      render 'edit'
    end
  end

  def destroy
    book = Book.find(params[:id])  # データ（レコード）を1件取得
    book.destroy  # データ（レコード）を削除
    redirect_to books_path
  end

    private

  def book_params
  params.require(:book).permit(:title, :body)
  end

  def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    redirect_to(books_path) unless @user == current_user
  end
end
