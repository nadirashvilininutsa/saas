json.extract! artifact, :id, :name, :file, :project_id, :created_at, :updated_at
json.url artifact_url(artifact, format: :json)