class ContactsController < ApplicationController
  before_action :authenticate_user!

  def show
    @contact = Contact.find(params[:id])
  end

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      ContactMailer.send_mail(@contact).deliver
      redirect_to contact_path(@contact.id), flash: { notice: "お問い合わせ内容が送信されました" }
    else
      render 'new'
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:id, :category, :subject, :message).merge(user_name: current_user.nickname)
  end
end
