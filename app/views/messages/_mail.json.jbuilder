json.extract! mail, :id, :mailbox_id, :content, :created_at, :updated_at
json.url mail_url(mail, format: :json)
