class Admin::ContactsController < ApplicationController
  def show
    @contact = Contact.find(params[:id])
  end

  def index
    @contacts = Contact.all
  end

  def update
    contact = Contact.find(params[:id])
    contact.update(reply_params)
    redirect_to action: :show
  end
end
