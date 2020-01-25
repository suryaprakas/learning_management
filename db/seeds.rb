# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies)

exams = Exam.create(title: 'Quarterly')

subjects = Subject.create(title: 'Maths', exam_id: exams.id)

topics = Topic.create(name: 'Numbers', subject_id: subjects.id)

chapters_1 = Chapter.create(name: 'Scalars', description: 'These are numbers used to measure some quantity to any desired degree of accuracy', topic_id: topics.id)
chapters_2 = Chapter.create(name: 'Number notation', description: 'There are various ways that numbers can be written or diagrammed.', topic_id: topics.id)

questions_1 =  Question.create(title: 'Real numbers can be..', question_type: Question::QuestionType::EASY, chapter_id: chapters_1.id)
questions_2 =  Question.create(title: 'Integers can be..', question_type: Question::QuestionType::HARD, chapter_id: chapters_1.id)


options_1_1 = Option.create(option: 'positive', question_id: questions_1.id)
options_1_2 = Option.create(option: 'negative or zero', question_id: questions_1.id)
options_1_3 = Option.create(option: 'decimal or fractional', question_id: questions_1.id)
options_1_4 = Option.create(option: 'all of the above', question_id: questions_1.id, is_correct: true)

options_2_1 = Option.create(option: 'positive', question_id: questions_2.id)
options_2_2 = Option.create(option: 'negative or zero', question_id: questions_2.id)
options_2_3 = Option.create(option: 'decimal or fractional', question_id: questions_2.id)
options_2_4 = Option.create(option: 'a and b', question_id: questions_2.id, is_correct: true)

questions_3 =  Question.create(title: 'Which is a decimal notation', question_type: Question::QuestionType::EASY, chapter_id: chapters_2.id)
questions_4 =  Question.create(title: 'Identify the fractions', question_type: Question::QuestionType::MEDIUM, chapter_id: chapters_2.id)


options_3_1 = Option.create(option: '23.00', question_id: questions_3.id, is_correct: true)
options_3_2 = Option.create(option: '0', question_id: questions_3.id)
options_3_3 = Option.create(option: '23/1', question_id: questions_3.id)
options_3_4 = Option.create(option: '23', question_id: questions_3.id)

options_2_1 = Option.create(option: '1/23', question_id: questions_4.id, is_correct: true)
options_2_2 = Option.create(option: '-7.9', question_id: questions_4.id)
options_2_3 = Option.create(option: '0', question_id: questions_4.id)
options_2_4 = Option.create(option: '3', question_id: questions_4.id)

