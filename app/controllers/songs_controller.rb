class SongsController < ApplicationController
  before_action :select_song, only: [:edit, :update, :destroy, :show]

  def new
    @song = Song.new
  end

  def create
    # binding.pry
    @song = Song.new(song_params)
    if @song.save
      redirect_to song_path(@song)
    else
      render :new
    end
  end

  def index
    @songs = Song.all
  end

  def show
  end

  def edit
  end

  def update
    @song.update(song_params)
    if @song.save
      redirect_to song_path(@song)
    else
      render :edit
    end
  end

  def destroy
    @song.destroy
    redirect_to songs_path
  end

  private

  def song_params
    params[:song].permit(:title, :released, :release_year, :artist_name, :genre)
  end

  def select_song
    @song = Song.find(params[:id])
  end

end
