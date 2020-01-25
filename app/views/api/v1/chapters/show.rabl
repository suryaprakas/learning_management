object @chapter

attributes :id, :subject_id, :name, :description

node :questions do |chapter|
  partial 'api/v1/questions/index', object: chapter.get_unattempted_questions(current_user)
end