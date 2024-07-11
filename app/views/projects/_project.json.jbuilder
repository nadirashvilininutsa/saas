json.extract! project, :id, :title, :description, :completion_date, :completed, :created_at, :updated_at
json.url project_url(project, format: :json)
