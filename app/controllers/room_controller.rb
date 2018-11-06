class RoomController < ApplicationController
  before_action :set_room, except: [:index, :new, :create]
  before_action :authentication_user!, except: [:show]

  def index
    @rooms = current_user.room
  end

  def new
    @room = current_user.room.build
  end

  def create
    @room = current_user.room.build(room_params)
    if @room.save
      flash[:notice] = "Saved"
    else
      flash[:notice] = "Something went wrong"
    end
    redirect_back(fall_back_location: request.referer)

  end

  def show
  end

  def listing
  end

  def pricing
  end

  def description
  end

  def photo_upload
  end

  def amenities
  end

  def location
  end

  def update
    if @room.update
      redirect_to :back, notice: "Saved"
    else

    end
  end

  private
    def set_room
      @room = Room.find(params[:id])
    end

    def room_params
      params.require(:room).permit(:home_type, :room_type, :accommodate, :bed_room, :bath_room, :listing_room, :summary, :address, :is_tv, :is_kitchen, :is_air, :is_heating, :is_internet, :price, :active)
    end
end
