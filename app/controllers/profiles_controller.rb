class ProfilesController < ApplicationController
    before_action :set_guest
    before_action :authenticate_guest!

    def show
    end

    def edit
    end

    def new
        @profile = @guest.build_profile
        authorize @profile
    end 

    def create
        @profile = @guest.create_profile(profile_params)
        authorize @profile
        
        respond_to do |format|
            if @profile.save
                format.html { redirect_to root_path, notice: "Profile was successfully created." }
            else
                format.html { render :new }
                format.json { render json: @profile.errors, status: :unprocessable_entity }
            end
        end
    end

    private

    def profile_params
        params.require(:profile).permit(:avatar, :name, :bio, :guest_id, :phone, :address, :zipcode)
    end 

    def set_guest
        @guest = Guest.find(params[:guest_id])
    end
end