class LeasesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity

    def index
        render json: Lease.all, status: :ok
    end

    def create
        lease = Lease.create!(lease_params)
        render json: lease, status: :created
    end

    def destroy
        lease = find_lease
        lease.destroy!
        head :no_content
    end

    private
    
    def lease_params
        params.permit(:rent, :apartment_id, :tenant_id)
    end

    def find_lease
        lease = Lease.find_by(id: params[:id])
    end

    def render_unprocessable_entity(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

    def render_record_not_found
        render json: {error: "Lease not found" }, status: :not_found
    end
end
