class Message < ApplicationRecord
  belongs_to :mailbox

  validate :content_present
  validates_presence_of :mailbox_id

  after_create :send_message_notification_email, if: :mailbox_confirmed?

  def send_message_notification_email
    MessageMailer.message_notification_email(self).deliver_later
  end

  def mailbox_confirmed?
    mailbox.confirmed?
  end

  private

  def content_present
    errors.add :content, 'empty' unless eval(self.content).present?
  end
end
