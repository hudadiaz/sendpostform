json.extract! mailbox, :id, :email, :access_token, :api_key, :created_at, :updated_at
json.url mailbox_url(mailbox, format: :json)
