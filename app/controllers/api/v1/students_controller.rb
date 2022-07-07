module Api
    module V1
        class StudentsController < ApplicationController
            before_action :set_student, only: [:show,:update, :destroy]
            def index
                render json: Student.all.order(id: :asc)
            end

            def show 
                render json: @student
            end

            def create
                @student = Student.new(students_params)
                if @student.save
                    render json: @student
                else
                    render json: @student.errors, status: :unprocessable_entity
                end
            end

            def update
                if @student.update(students_params)
                    render json: @student
                else
                    render json: @student.errors, status: :unprocessable_entity
                end
            end

            def destroy
                if @student.destroy
                    render json: @student
                else
                    render json: @student.errors, status: :unprocessable_entity
                end
            end
            
            private

            def set_student
                @student = Student.find(params[:id])
            end
            
            def students_params
                params.require(:student).permit(:name, :last_name)
            end
        end
    end
end