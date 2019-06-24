require 'oj'

module Api
  module V1
    # AppointmentsController
    class AppointmentsController < ApplicationController
      # before_action :authenticate_user!

      def index
        @appointments = Appointment.order('appt_time ASC')
        render json: Oj.to_json(@appointments)
      end

      def show
        @appointment = find_appointment(params[:id])
        render json: Oj.to_json(@appointment)
      end

      def create
        @appointment = Appointment.new
        @appointment.title = params[:appointment][:title]
        @appointment.appt_time = params[:appointment][:appt_time]

        @appointment.user = User.first

        if @appointment.save
          render json: Oj.to_json(@appointment)
        else
          render json: Oj.to_json(@appointment.errors), status: :unprocessable_entity
        end
      end

      def update
        @appointment = find_appointment(params[:id])

        @appointment.title = params[:appointment][:title]
        @appointment.appt_time = params[:appointment][:appt_time]

        if @appointment.update(appointment_params)
          render json: Oj.to_json(@appointment)
        else
          render json: Oj.to_json(@appointment.errors), status: :unprocessable_entity
        end
      end

      def destroy
        @appointment = find_appointment(params[:id])
        if @appointment.destroy
          head :no_content, status: :ok
        else
          render json: Oj.to_json(@appointment.errors), status: :unprocessable_entity
        end
      end

      private

      def appointment_params
        params.require(:appointment).permit(:title).permit(:appt_time)
      end

      def find_appointment(id)
        #current_user.appointments.find(id)
        Appointment.find(id)
      end
    end
  end
end
