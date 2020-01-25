object @subject

attributes :id, :exam_id, :title, :description

node :topics do |subject|
  partial 'api/v1/topics/index', object: subject.topics
end