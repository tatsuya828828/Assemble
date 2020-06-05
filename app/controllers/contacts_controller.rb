class ContactsController < ApplicationController

  def new
    @contact = Contact.new
  end

  def create
    contact = Contact.new(contact_params)
    contact.save
    redirect_to action: :index
  end

  def show
    @contact = Contact.find(params[:id])
    if (@contact.confirm_status == "admin_confirmed") && (@contact.reply.present?)
      @contact.update(confirm_status: "user_confirmed")
    end
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
