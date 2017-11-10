class MailboxesController < ApplicationController
  before_action :set_mailbox, only: [:show, :destroy]
  def show
    @messages = @mailbox.messages.order(created_at: :desc)
  end

  def new
    @mailbox = Mailbox.new
  end

  def create
    @mailbox = Mailbox.new(mailbox_params)

    respond_to do |format|
      if @mailbox.save
        set_current_mailbox @mailbox
        format.html { redirect_to current_mailbox_path, notice: 'Mailbox was successfully created.' }
        format.json { render :show, status: :created, location: @mailbox }
      else
        format.html { redirect_to root_path, notice: @mailbox.errors }
        format.json { render json: @mailbox.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @mailbox.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Mailbox was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    def set_mailbox
      @mailbox = current_mailbox
    end

    def mailbox_params
      params.require(:mailbox).permit(:email)
    end
end
