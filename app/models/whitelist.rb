class Whitelist < ApplicationRecord
  belongs_to :mailbox

  validate :validate_hostname
  validates_presence_of :mailbox, :hostname
  validates_uniqueness_of :hostname, scope: :mailbox_id

  private

  def validate_hostname
    self.hostname = URI(hostname).host || self.hostname
  rescue URI::InvalidURIError
    errors.add :hostname, 'invalid URI'
  end
end
