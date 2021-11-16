class Admins::GenresController < ApplicationController
  def index
    @genres = Genre.all
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      flash[:notice] = "新しいジャンルを登録しました"
      redirect_to admins_genres_path
    else
      flash[:error] = "入力してください"
      render :index
    end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      flash[:notice] = "ジャンル名を変更しました。"
      redirect_to admins_genres_path
    else
      flash[:error] = "変更できません"
      render :edit
    end
  end

  private
  def genre_params
    params.require(:genre).permit(:name)
  end

  def user_block
    if customer_sign_in?
      redirect_to root_path
    end
  end
end
