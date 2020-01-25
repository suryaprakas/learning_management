object @topic

attributes :id, :subject_id, :name, :description

node :chapters do |topic|
  partial 'api/v1/chapters/index', object: topic.chapters
end
# child(@topic.chapters, object_root: false) { extends 'api/v1/chapters/index' }