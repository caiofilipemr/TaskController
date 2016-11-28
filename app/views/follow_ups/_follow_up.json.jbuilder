json.extract! follow_up, :id, :details, :updates, :task_id, :user_id, :created_at, :updated_at
json.url follow_up_url(follow_up, format: :json)