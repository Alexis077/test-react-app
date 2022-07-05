module Api
    module V1
        class CoursesController < ApplicationController
            before_action :set_course, only: [:show,:update, :destroy]
            def index
                render json: Course.all
            end

            def show 
                render json: @course
            end

            def create
                @course = Course.new(course_params)
                if @course.save
                    render json: @course
                else
                    render json: @course.errors, status: :unprocessable_entity
                end
            end

            def update
                if @course.update(course_params)
                    render json: @course
                else
                    render json: @course.errors, status: :unprocessable_entity
                end
            end

            def destroy
                if @course.destroy
                    render json: @course
                else
                    render json: @course.errors, status: :unprocessable_entity
                end
            end
            
            private

            def set_course
                @course = Course.find(params[:id])
            end
            
            def course_params
                params.require(:course).permit(:name)
            end
        end
    end
end