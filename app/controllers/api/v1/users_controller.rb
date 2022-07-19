module Api
    module V1
        class UsersController < ApplicationController
            skip_before_action :authenticate_request, only: [:create, :update]
            before_action :set_user, only: [:show,:update, :destroy]
            
            def index
                render json: User.all
            end

            def show 
                render json: @user
            end

            def create
                @user = User.new(user_params)
                if @user.save
                    render json: @user
                else
                    render json: @user.errors, status: :unprocessable_entity
                end
            end

            def update
                if @user.update(user_params)
                    render json: @user
                else
                    render json: @user.errors, status: :unprocessable_entity
                end
            end

            def destroy
                if @user.destroy
                    render json: @user
                else
                    render json: @user.errors, status: :unprocessable_entity
                end
            end
            
            private

            def set_user
                @user = User.find(params[:id])
            end
            
            def user_params
                params.require(:user).permit(:username, :email, :password)
            end
        end        
    end
end
