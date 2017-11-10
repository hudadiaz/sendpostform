class Mailbox < ApplicationRecord
  has_many :messages
  has_many :whitelists

  validates :email,
            presence: true,
            uniqueness: true

  before_create :generate_api_key
  before_create :generate_access_token
  before_create :generate_confirmation_token
  after_create :allows_sendpostform
  after_create :send_confirmation_email, unless: :confirmed?

  def allows? referrer
    whitelists = self.whitelists.select(:hostname).map(&:hostname)
    return true if whitelists.include? '*'
    hostname = URI(referrer.to_s).host
    whitelists.include? hostname
  end

  def generate_api_key
    while Mailbox.find_by api_key: (self.api_key = SecureRandom.uuid.to_s.gsub('-', ''))
    end
    api_key
  end

  def generate_access_token
    while Mailbox.find_by access_token: (self.access_token = SecureRandom.base64(24))
    end
    access_token
  end

  def send_confirmation_email
    MailboxMailer.confirmation_email(self).deliver_later
  end

  def confirm!
    unless confirmed?
      self.confirmed_at = Time.now
      self.save
    end
  end

  def confirmed?
    confirmed_at.present?
  end

  def request_reset_token
    self.generate_reset_token
    if self.save
      MailboxMailer.reset_token_email(self).deliver_later
    end
  end

  def generate_reset_token
    while Mailbox.find_by reset_token: (self.reset_token = SecureRandom.urlsafe_base64(64))
    end
    self.reset_token_generated_at = Time.now
    reset_token
  end

  private

  def allows_sendpostform
    whitelists.create! hostname: ENV['HOSTNAME']
  end

  def generate_confirmation_token
    while Mailbox.find_by confirmation_token: (self.confirmation_token = SecureRandom.urlsafe_base64(64))
    end
    confirmation_token
  end
end
