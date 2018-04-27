SELECT tests.id AS test_id,
       statements.value AS scenario,
       tests.participant_id AS participant_id,
       tests.statement_read,
       tests.completed,
       questions.value AS question,
       answers.value AS given_answer
FROM tests
LEFT JOIN statements
ON        statements.id = tests.statement_id
LEFT JOIN test_questions
ON        test_questions.test_id = tests.id
LEFT JOIN questions
ON        questions.id = test_questions.question_id
LEFT JOIN answers_test_questions
ON        answers_test_questions.test_question_id = test_questions.id
LEFT JOIN answers
ON        answers.id = answers_test_questions.answer_id