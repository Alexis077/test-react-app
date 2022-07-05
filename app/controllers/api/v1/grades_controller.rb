module Api
    module V1
        class GradesController < ApplicationController
            before_action :set_grade, only: [:show,:update, :destroy]
            def index
                render json: Grade.all
            end

            def show 
                render json: @grade
            end

            def create
                @grade = Grade.new(grade_params)
                if @grade.save
                    render json: @grade
                else
                    render json: @grade.errors, status: :unprocessable_entity
                end
            end

            def update
                if @grade.update(grade_params)
                    render json: @grade
                else
                    render json: @grade.errors, status: :unprocessable_entity
                end
            end

            def destroy
                if @grade.destroy
                    render json: @grade
                else
                    render json: @grade.errors, status: :unprocessable_entity
                end
            end
            
            private

            def set_grade
                @grade = Grade.find(params[:id])
            end
            
            def grade_params
                params.require(:grade).permit(:students_id, :courses_id, :quarter, :score)
            end
        end
    end
end