class SessionsController < ApplicationController
    def new
    end

    def create
        user = User.find_by(username: params[:username_or_email]) || User.find_by(email: params[:username_or_email])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect_to (session[:intended_url] || user),
                         notice: "Welcome back, #{user.name}"
            session[:intended_url] = nil
        else
            flash.now[:alert] = "Invalid Login/Password combination!"
            render :new, status: :unprocessable_entity
        end
    end

    def destroy
        session[:user_id] = nil
        redirect_to :root, status: :see_other, alert: "Signed off"
    end
end
