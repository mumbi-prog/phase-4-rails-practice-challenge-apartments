class ApartmentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity
    
        def index
            render json: Apartment.all, status: :ok
        end
    
        def show
            apartment = find_apartment
            render json: apartment, status: :ok
        end
    
        def create
            apartment = Apartment.create!(apartment_params)
            render json: apartment, status: :created
        end
    
        def update
            apartment = find_apartment
            apartment.update!(apartment_params)
            apartment.save!
            render json: apartment, status: :accepted
        end
    
        def destroy
            apartment = find_apartment
            apartment.destroy!
            head :no_content
        end
    
        private
    
        def apartment_params
            params.permit(:number)
        end
    
        def find_apartment
            apartment = Apartment.find_by(id: params[:id])
        end
    
        def render_unprocessable_entity(invalid)
            render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
        end
    
        def render_record_not_found
            render json: {error: "Apartment not found" }, status: :not_found
        end
end
