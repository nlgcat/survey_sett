# Useful functions
require 'csv'
def csv_to_hash(file_location)
    csv = CSV::parse(File.open(file_location, 'r') {|f| f.read })
    fields = csv.shift
    fields = fields.map {|f| f.downcase.gsub(" ", "_")}
    csv.collect { |record| Hash[*fields.zip(record).flatten ] } 
end

# Consent
@project_name = 'Explainer Systems'

# Consent Statements
h = {
  explained:    "By ticking this box I confirm that the research project <strong>#{@project_name}</strong> has been explained to me. I have had the opportunity to ask questions about the project and have had these answered satisfactorily.", 
  insights:     "By ticking this box I consent to the material I contribute being used to generate insights for the research project <strong>#{@project_name}</strong>.",
  # voluntary:    "By ticking this box I understand that my participation in this research is voluntary and that I may withdraw from the study at any time.",
  voluntary:    "By ticking this box I understand that my participation in this research is voluntary and that I may stop entering data at any point. All submitted data is anonymous and it is not possible for the researcher to identify me.  I understand that because of this, my submitted data cannot be shown to me or deleted at a later date.  Any participants who have entered incomplete data will have their data removed automatically.",
  future:       "By ticking this box I consent to allow the fully anonymised data to be used for future publications and other scholarly means of disseminating the findings from the research project.",
  stored:       "By ticking this box I understand that the information/data acquired will be securely stored by researchers, but that appropriately anonymised data may in future be made available to others for research purposes only.",
  age:          "By ticking this box I confirm that I am over the age of 18 and that I have read and understood all of the above statements."
}

h.each do |name, text|
  ConsentStatement.create(statement_name: name, text: text)
end

# Gender - TODO - Get this in YAML
['Female', 'Male', 'Other', 'Prefer not to say'].each do |gender|
  Gender.create(value: gender)
end

['High School', 'Bachelors Degree', 'Masters Degree', 'Doctorate', 'N/A', 'Prefer not to say'].each do |e|
  EducationLevel.create(value: e)
end

# Question Types
QuestionType.create(name: QuestionType::WARMUP,       quantity_required: 6, live: false)
QuestionType.create(name: QuestionType::DISTRACTOR,   quantity_required: 3, live: false)
QuestionType.create(name: QuestionType::CATEGORY_A,   quantity_required: 1, live: true)
QuestionType.create(name: QuestionType::CATEGORY_B,   quantity_required: 1, live: true)
QuestionType.create(name: QuestionType::CATEGORY_C,   quantity_required: 1, live: true)

# Question Formats
QuestionFormat.create(name: QuestionFormat::LIKERT)

# Experiments
t = Time.now
@experiment = Experiment.create(start_date: t, end_date: t + 4.week)

# Explainer Categories
ExplainerCategory.create(name: 'A', description: "Fill me in!")
ExplainerCategory.create(name: 'B', description: "Fill me in!")
ExplainerCategory.create(name: 'C', description: "Fill me in!")
ExplainerCategory.create(name: 'D', description: "Fill me in!")
ExplainerCategory.create(name: 'E', description: "Fill me in!")

arr = [
  {
    context:  'The blah blah blah AI system does blah blah blah',
    img:      'blah.jpg',
    txt:      nil,
    category: 'A'
  },
  {
    context:  'The blah blah blah AI system does blah blah blah',
    img:      'blah.jpg',
    txt:      nil,
    category: 'B'
  },
  {
    context:  'The blah blah blah AI system does blah blah blah',
    img:      'blah.jpg',
    txt:      nil,
    category: 'C'
  },
  {
    context:  'The blah blah blah AI system does blah blah blah',
    img:      'blah.jpg',
    txt:      nil,
    category: 'D'
  },
  {
    context:  'The blah blah blah AI system does blah blah blah',
    img:      'blah.jpg',
    txt:      nil,
    category: 'E'
  },
  {
    context:  'The blah blah blah AI system does blah blah blah',
    img:      nil,
    txt:      'The explanation is blah blah blah',
    category: 'A'
  },
  {
    context:  'The blah blah blah AI system does blah blah blah',
    img:      nil,
    txt:      'The explanation is blah blah blah',
    category: 'B'
  },
  {
    context:  'The blah blah blah AI system does blah blah blah',
    img:      nil,
    txt:      'The explanation is blah blah blah',
    category: 'C'
  },
  {
    context:  'The blah blah blah AI system does blah blah blah',
    img:      nil,
    txt:      'The explanation is blah blah blah',
    category: 'D'
  },
  {
    context:  'The blah blah blah AI system does blah blah blah',
    img:      nil,
    txt:      'The explanation is blah blah blah',
    category: 'E'
  },
]

arr.each do |h|
  # Create the explainer (looking up to find the Explainer Category)
  explainer_category = ExplainerCategory.find(name: h[:category])
  explainer = Explainer.create(explainer_category_id: explainer_category.id)

  # Note this allows for BOTH image and text explanation, just make sure and set the above input right if you want XOR
  if h[:img] != nil
    explainer_image = ExplainerImage.find_or_create(url: h[:img])
    explainer.explainer_image = explainer_image
  end

  # Note this allows for BOTH image and text explanation, just make sure and set the above input right if you want XOR
  if h[:txt] != nil
    explainer_text = ExplainerText.find_or_create(text: h[:txt])
    explainer.explainer_text = explainer_text
  end

  # Create a statement and pair it with an explainer
  statement = Statement.create(experiment_id: @experiment.id, value: h[:context])
  statement.explainer = explainer

  # Add questions to the statement
  explainer.questions.each do |question|
    statement.add_question question
  end
end

pp Statement.all