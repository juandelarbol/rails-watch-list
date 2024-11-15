class BookmarksController < ApplicationController
  before_action :set_list, only: [:new, :create]
  
  def new
    @bookmark = Bookmark.new
  end
  
  def create
    @bookmark = Bookmark.new(bookmarks_params)

    @bookmark.list = List.find(params[:list_id])
    # Alternative
    #@bookmark.list_id = params[:list_id]
    if @bookmark.save
      redirect_to list_path(@list)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    redirect_to list_path(@bookmark.list)

  end

  private

  def set_list
    @list = List.find(params[:list_id])
  end

  def bookmarks_params
    params.require(:bookmark).permit(:movie_id, :comment)
  end
end
