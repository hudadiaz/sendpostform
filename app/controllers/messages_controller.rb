class MessagesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]
  before_action :set_mailbox, except: [:create]
  before_action :set_message, only: [:show, :destroy]

  def index
    @messages = @mailbox.messages.order(created_at: :desc)
  rescue NoMethodError
    redirect_to root_path, notice: 'Create a Mailbox first.'
  end

  def show
  end

  def create
    continue_path = params[:redirect_to].present? ? params[:redirect_to] : request.referer
    @mailbox = Mailbox.find_by api_key: params[:api_key]
    unless @mailbox && @mailbox.allows?(request.referer)
      return redirect_to continue_path, notice: 'Could not submit form. Please contact administrator.'
    end

    @message = @mailbox.messages.new(message_params)

    respond_to do |format|
      if @message.save
        format.html { redirect_to continue_path, notice: 'Message was successfully created.' }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { redirect_to continue_path, notice: 'Something went wrong, message was not sent.' }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to mailbox_messages_url(mailbox_id: :current), notice: 'Message was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  def delete_all
    @messages = @mailbox.messages
    count = @messages.size
    @messages.destroy_all
    respond_to do |format|
      format.html { redirect_to mailbox_messages_url(mailbox_id: :current), notice: "#{count} messages was successfully deleted." }
      format.json { head :no_content }
    end
  end

  private
    def set_mailbox
      @mailbox = current_mailbox
    end

    def set_message
      @message = @mailbox.messages.find(params[:id])
    end

    def message_params
      {
        subject: params.fetch('subject', nil),
        content: params.except(:controller, :action, :api_key, :redirect_to, :subject).delete_if { |k, v| v.empty? }.to_s
      }
    end
end
