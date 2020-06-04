class ContactsController < ApplicationController

  def new
    @contact = Contact.new
  end

  def create
    contact = contact.new(contact_params)
    contact.save
    redirect_to action: :index
  end

  def show
    @contact = Contact.find(params[:id])
  end

  def index
    @contacts = current_user.contacts.all
  end

  def destroy
    contact = Contact.find(params[:id])
    contact.destroy
    redirect_to action: :index
  end

  private

  def contact_params
    params.require(:contact).permit(:title, :body, :user_id)
  end

end
