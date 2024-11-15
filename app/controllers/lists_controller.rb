class ListsController < ApplicationController
  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    if @list.save
      redirect_to list_path(@list)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    set_list
    all_bookmarks = Bookmark.all
    @selected_bookmarks = all_bookmarks.select{ |bookmark| bookmark.list_id == @list.id } 
    @bookmark = Bookmark.new
  end

  def index
    @lists = List.all
    new
  end

  private 

  def set_list
    @list = List.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:name)
  end
end
