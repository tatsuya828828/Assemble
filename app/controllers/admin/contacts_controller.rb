class Admin::ContactsController < ApplicationController
  def show
    @contact = Contact.find(params[:id])
    @contact.update(confirm_status: "admin_confirmed")
  end

  def index
    @contacts = Contact.all
  end

  def update
    contact = Contact.find(params[:id])
    contact.update(reply_params)
    redirect_to action: :show
  end

  private

  def reply_params
    params.permit(:reply, :response_status)
  end

end
