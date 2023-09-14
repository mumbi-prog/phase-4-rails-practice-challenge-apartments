class TenantsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity
    
        def index
            render json: Tenant.all, status: :ok
        end
    
        def show
            tenant = find_tenant
            render json: tenant, include: :leases, status: :ok
        end
    
        def create
            tenant = Tenant.create!(tenant_params)
            render json: tenant, status: :created
        end
    
        def update
            tenant = find_tenant
            tenant.update!(tenant_params)
            tenant.save!
            render json: tenant, status: :accepted
        end
    
        def destroy
            tenant = find_tenant
            tenant.destroy!
            head :no_content
        end
    
        private
    
        def tenant_params
            params.permit(:name, :age)
        end
    
        def find_tenant
            tenant = Tenant.find_by(id: params[:id])
        end
    
        def render_unprocessable_entity(invalid)
            render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
        end
    
        def render_record_not_found
            render json: {error: "Tenant not found" }, status: :not_found
        end
end
