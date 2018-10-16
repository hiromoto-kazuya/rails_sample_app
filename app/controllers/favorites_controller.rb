class FavoritesController < ApplicationController
  respond_to? :js

  def create
    @favorite = current_user.favorites.create(blog_id: params[:blog_id])
  end

  def destroy
    @favorite = current_user.favorites.find_by(id: params[:id]).destroy
  end
end
