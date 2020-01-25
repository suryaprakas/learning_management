object @exam

extends 'api/v1/exams/details'

child(@exam.subjects, object_root: false) { extends 'api/v1/subjects/index.rabl' }