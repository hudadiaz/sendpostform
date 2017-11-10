class WhitelistsController < ApplicationController
  before_action :set_mailbox
  before_action :set_whitelist, only: [:show, :edit, :update, :destroy]

  def index
    @whitelists = @mailbox.whitelists.all
    @whitelist = @mailbox.whitelists.new
  end

  def create
    @whitelist = @mailbox.whitelists.new(whitelist_params)

    respond_to do |format|
      if @whitelist.save
        format.html { redirect_to mailbox_whitelists_url(mailbox_id: :current), notice: 'Whitelist was successfully added.' }
        format.json { render :show, status: :created, location: @whitelist }
      else
        format.html { redirect_to mailbox_whitelists_url(mailbox_id: :current), notice: @whitelist.errors }
        format.json { render json: @whitelist.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @whitelist.destroy
    respond_to do |format|
      format.html { redirect_to mailbox_whitelists_url(mailbox_id: :current), notice: 'Whitelist was successfully renived.' }
      format.json { head :no_content }
    end
  end

  private
    def set_mailbox
      @mailbox = Mailbox.find_by access_token: session[:access_token]
    end

    def set_whitelist
      @whitelist = @mailbox.whitelists.find(params[:id])
    end

    def whitelist_params
      params.require(:whitelist).permit(:hostname)
    end
end
