require 'test_helper'

class MessagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @message = messages(:one)
  end

  test "should get index" do
    get mails_url
    assert_response :success
  end

  test "should get new" do
    get new_messages_url
    assert_response :success
  end

  test "should create mail" do
    assert_difference('Mail.count') do
      post mails_url, params: { mail: { content: @message.content, mailbox: @message.mailbox } }
    end

    assert_redirected_to messages_url(Mail.last)
  end

  test "should show mail" do
    get messages_url(@message)
    assert_response :success
  end

  test "should get edit" do
    get edit_messages_url(@message)
    assert_response :success
  end

  test "should update mail" do
    patch messages_url(@message), params: { mail: { content: @message.content, mailbox: @message.mailbox } }
    assert_redirected_to messages_url(@message)
  end

  test "should destroy mail" do
    assert_difference('Mail.count', -1) do
      delete messages_url(@message)
    end

    assert_redirected_to mails_url
  end
end
