# frozen_string_literal: true

class RoomsController < ApplicationController
  protect_from_forgery except: [:create]
  before_action :set_room, except: %i[index new create]
  before_action :authenticate_user!, except: [:show]
  before_action :is_authorised, only: %i[listing pricing description photo_upload amenities location update]

  def index
    @rooms = current_user.rooms
  end

  def new
    @room = current_user.rooms.build
  end

  def create
    @room = current_user.rooms.build(room_params)
    if @room.save
      flash[:notice] = 'Saved'
      redirect_to listing_room_path(@room), notice: 'Saved...'
    else
      flash[:notice] = 'Something went wrong'
      render :new
    end
  end

  def show
    @photos = @room.photos
  end

  def listing; end

  def pricing; end

  def description; end

  def photo_upload
    @photos = @room.photos
  end

  def amenities; end

  def location; end

  def update
    new_params = room_params
    new_params = room_params.merge(active: true) if is_ready_room
    flash[:notice] = if @room.update(room_params)
                       'Saved'
                     else
                       'Something went wrong'
                     end
    redirect_back(fallback_location: request.referer)
  end

  private

  def set_room
    @room = Room.find(params[:id])
  end

  def is_authorised
    redirect_to root_path, alert: "You don't have permission" unless current_user.id == @room.user_id
  end

  def is_ready_room
    !@room.active && !@room.price.blank? && !@room.listing_name.blank? && !@room.photos.blank? && !@room.address.blank?
  end

  def room_params
    params.require(:room).permit(:home_type, :room_type, :accommodate, :bed_room, :bath_room, :listing_room, :summary, :address, :is_tv, :is_kitchen, :is_air, :is_heating, :is_internet, :price, :active)
  end
end
