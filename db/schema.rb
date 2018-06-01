Sequel.migration do
  change do
    create_table(:age_ranges) do
      primary_key :id
      column :value, "text"
      column :created_at, "timestamp without time zone", :null=>false
      column :updated_at, "timestamp without time zone", :null=>false
      
      index [:value], :unique=>true
    end
    
    create_table(:answers) do
      primary_key :id
      column :value, "text", :null=>false
      column :correct, "boolean", :default=>false, :null=>false
      column :created_at, "timestamp without time zone", :null=>false
      column :updated_at, "timestamp without time zone", :null=>false
      
      index [:correct]
    end
    
    create_table(:consent_statements) do
      primary_key :id
      column :statement_name, "text", :null=>false
      column :text, "text", :null=>false
      column :created_at, "timestamp without time zone", :null=>false
      column :updated_at, "timestamp without time zone", :null=>false
      
      index [:statement_name], :unique=>true
    end
    
    create_table(:education_levels) do
      primary_key :id
      column :value, "text", :null=>false
      column :created_at, "timestamp without time zone", :null=>false
      column :updated_at, "timestamp without time zone", :null=>false
      
      index [:value], :unique=>true
    end
    
    create_table(:experiments) do
      primary_key :id
      column :start_date, "timestamp without time zone", :null=>false
      column :end_date, "timestamp without time zone", :null=>false
      column :completed, "boolean", :default=>false, :null=>false
      column :created_at, "timestamp without time zone", :null=>false
      column :updated_at, "timestamp without time zone", :null=>false
      
      index [:completed]
      index [:end_date]
      index [:start_date]
    end
    
    create_table(:explainer_categories) do
      primary_key :id
      column :name, "text", :null=>false
      column :description, "text", :null=>false
      column :created_at, "timestamp without time zone", :null=>false
      column :updated_at, "timestamp without time zone", :null=>false
      
      index [:name], :unique=>true
    end
    
    create_table(:explainer_images) do
      primary_key :id
      column :url, "text", :null=>false
      column :created_at, "timestamp without time zone", :null=>false
      column :updated_at, "timestamp without time zone", :null=>false
      
      index [:url], :unique=>true
    end
    
    create_table(:explainer_texts) do
      primary_key :id
      column :text, "text", :null=>false
      column :created_at, "timestamp without time zone", :null=>false
      column :updated_at, "timestamp without time zone", :null=>false
      
      index [:text]
    end
    
    create_table(:funders) do
      primary_key :id
    end
    
    create_table(:genders) do
      primary_key :id
      column :value, "text"
      column :created_at, "timestamp without time zone", :null=>false
      column :updated_at, "timestamp without time zone", :null=>false
      
      index [:value], :unique=>true
    end
    
    create_table(:participants) do
      primary_key :id
      column :uid, "text", :null=>false
      column :final_consent, "boolean", :default=>false, :null=>false
      column :native, "boolean", :default=>false, :null=>false
      column :created_at, "timestamp without time zone", :null=>false
      column :updated_at, "timestamp without time zone", :null=>false
      
      index [:final_consent]
      index [:native]
      index [:uid], :unique=>true
    end
    
    create_table(:question_formats) do
      primary_key :id
      column :name, "text", :null=>false
      column :view, "text", :null=>false
      column :created_at, "timestamp without time zone", :null=>false
      column :updated_at, "timestamp without time zone", :null=>false
      
      index [:name], :unique=>true
      index [:view]
    end
    
    create_table(:question_types) do
      primary_key :id
      column :name, "text", :null=>false
      column :quantity_required, "integer", :null=>false
      column :live, "boolean", :null=>false
      column :created_at, "timestamp without time zone", :null=>false
      column :updated_at, "timestamp without time zone", :null=>false
      
      index [:live]
      index [:name]
      index [:quantity_required]
    end
    
    create_table(:researchers) do
      primary_key :id
    end
    
    create_table(:schema_migrations) do
      column :filename, "text", :null=>false
      
      primary_key [:filename]
    end
    
    create_table(:age_ranges_participants) do
      foreign_key :age_range_id, :age_ranges, :null=>false, :key=>[:id]
      foreign_key :participant_id, :participants, :null=>false, :key=>[:id]
      
      index [:age_range_id, :participant_id], :unique=>true
    end
    
    create_table(:answers_participant) do
      foreign_key :answer_id, :answers, :null=>false, :key=>[:id], :on_delete=>:cascade
      foreign_key :participant_id, :participants, :null=>false, :key=>[:id], :on_delete=>:cascade
      
      index [:answer_id], :unique=>true
      index [:participant_id], :unique=>true
    end
    
    create_table(:consent_statements_participants) do
      foreign_key :consent_statement_id, :consent_statements, :null=>false, :key=>[:id]
      foreign_key :participant_id, :participants, :null=>false, :key=>[:id]
      
      index [:consent_statement_id, :participant_id], :name=>:consent_statements_participants_consent_statement_id_participan, :unique=>true
    end
    
    create_table(:education_levels_participants) do
      foreign_key :education_level_id, :education_levels, :null=>false, :key=>[:id]
      foreign_key :participant_id, :participants, :null=>false, :key=>[:id]
      
      index [:education_level_id, :participant_id], :name=>:education_levels_participants_education_level_id_participant_id, :unique=>true
    end
    
    create_table(:explainers) do
      primary_key :id
      foreign_key :explainer_category_id, :explainer_categories, :null=>false, :key=>[:id]
      column :created_at, "timestamp without time zone", :null=>false
      column :updated_at, "timestamp without time zone", :null=>false
    end
    
    create_table(:genders_participants) do
      foreign_key :gender_id, :genders, :null=>false, :key=>[:id]
      foreign_key :participant_id, :participants, :null=>false, :key=>[:id]
      
      index [:gender_id, :participant_id], :unique=>true
    end
    
    create_table(:questions) do
      primary_key :id
      foreign_key :question_type_id, :question_types, :null=>false, :key=>[:id]
      foreign_key :question_format_id, :question_formats, :null=>false, :key=>[:id]
      column :value, "text", :null=>false
      column :layer, "integer", :default=>0, :null=>false
      column :created_at, "timestamp without time zone", :null=>false
      column :updated_at, "timestamp without time zone", :null=>false
      
      index [:layer]
      index [:question_type_id]
    end
    
    create_table(:statements) do
      primary_key :id
      foreign_key :experiment_id, :experiments, :null=>false, :key=>[:id]
      column :assigned, "boolean", :default=>false, :null=>false
      column :test_order, "integer", :default=>0, :null=>false
      column :value, "text", :default=>"", :null=>false
      column :created_at, "timestamp without time zone", :null=>false
      column :updated_at, "timestamp without time zone", :null=>false
      
      index [:assigned]
      index [:experiment_id]
      index [:test_order]
    end
    
    create_table(:answers_questions) do
      foreign_key :answer_id, :answers, :null=>false, :key=>[:id]
      foreign_key :question_id, :questions, :null=>false, :key=>[:id]
      
      index [:answer_id, :question_id], :unique=>true
    end
    
    create_table(:explainer_images_explainers) do
      foreign_key :explainer_id, :explainers, :null=>false, :key=>[:id]
      foreign_key :explainer_image_id, :explainer_images, :null=>false, :key=>[:id]
      
      index [:explainer_id, :explainer_image_id], :name=>:explainer_images_explainers_explainer_id_explainer_image_id_ind, :unique=>true
    end
    
    create_table(:explainer_texts_explainers) do
      foreign_key :explainer_id, :explainers, :null=>false, :key=>[:id]
      foreign_key :explainer_text_id, :explainer_texts, :null=>false, :key=>[:id]
      
      index [:explainer_id, :explainer_text_id], :unique=>true
    end
    
    create_table(:explainers_statements) do
      foreign_key :explainer_id, :explainers, :null=>false, :key=>[:id]
      foreign_key :statement_id, :statements, :null=>false, :key=>[:id]
      
      index [:explainer_id, :statement_id], :unique=>true
    end
    
    create_table(:questions_statements) do
      foreign_key :statement_id, :statements, :null=>false, :key=>[:id], :on_delete=>:cascade
      foreign_key :question_id, :questions, :null=>false, :key=>[:id], :on_delete=>:cascade
      
      index [:question_id]
      index [:statement_id]
    end
    
    create_table(:tests) do
      primary_key :id
      foreign_key :participant_id, :participants, :null=>false, :key=>[:id], :on_delete=>:cascade
      foreign_key :statement_id, :statements, :null=>false, :key=>[:id], :on_delete=>:cascade
      column :statement_read, "boolean", :default=>false, :null=>false
      column :statement_shown, "boolean", :default=>false, :null=>false
      column :completed, "boolean", :default=>false, :null=>false
      column :created_at, "timestamp without time zone", :null=>false
      column :updated_at, "timestamp without time zone", :null=>false
      
      index [:completed]
      index [:participant_id, :statement_id], :unique=>true
      index [:statement_read]
      index [:statement_shown]
    end
    
    create_table(:test_questions) do
      primary_key :id
      foreign_key :test_id, :tests, :null=>false, :key=>[:id], :on_delete=>:cascade
      foreign_key :question_id, :questions, :null=>false, :key=>[:id], :on_delete=>:cascade
      column :created_at, "timestamp without time zone", :null=>false
      column :updated_at, "timestamp without time zone", :null=>false
      
      index [:question_id]
      index [:test_id]
    end
    
    create_table(:answers_test_questions) do
      foreign_key :answer_id, :answers, :null=>false, :key=>[:id], :on_delete=>:cascade
      foreign_key :test_question_id, :test_questions, :null=>false, :key=>[:id], :on_delete=>:cascade
      
      index [:answer_id, :test_question_id]
    end
  end
end
              Sequel.migration do
                change do
                  self << "SET search_path TO \"$user\", public"
                  self << "INSERT INTO \"schema_migrations\" (\"filename\") VALUES ('20171031070313_create_genders.rb')"
self << "INSERT INTO \"schema_migrations\" (\"filename\") VALUES ('20171031070321_create_participants.rb')"
self << "INSERT INTO \"schema_migrations\" (\"filename\") VALUES ('20171031070327_create_experiments.rb')"
self << "INSERT INTO \"schema_migrations\" (\"filename\") VALUES ('20171031070353_create_statements.rb')"
self << "INSERT INTO \"schema_migrations\" (\"filename\") VALUES ('20171031070404_create_question_types.rb')"
self << "INSERT INTO \"schema_migrations\" (\"filename\") VALUES ('20171031070405_create_question_formats.rb')"
self << "INSERT INTO \"schema_migrations\" (\"filename\") VALUES ('20171031070408_create_questions.rb')"
self << "INSERT INTO \"schema_migrations\" (\"filename\") VALUES ('20171031070412_create_answers.rb')"
self << "INSERT INTO \"schema_migrations\" (\"filename\") VALUES ('20171101065111_create_genders_participants.rb')"
self << "INSERT INTO \"schema_migrations\" (\"filename\") VALUES ('20171101065636_create_consent_statements.rb')"
self << "INSERT INTO \"schema_migrations\" (\"filename\") VALUES ('20171101065933_create_consent_statements_participants.rb')"
self << "INSERT INTO \"schema_migrations\" (\"filename\") VALUES ('20171101075701_create_questions_statements.rb')"
self << "INSERT INTO \"schema_migrations\" (\"filename\") VALUES ('20171103115218_create_answers_participants.rb')"
self << "INSERT INTO \"schema_migrations\" (\"filename\") VALUES ('20171107070216_create_tests.rb')"
self << "INSERT INTO \"schema_migrations\" (\"filename\") VALUES ('20171107070221_create_test_questions.rb')"
self << "INSERT INTO \"schema_migrations\" (\"filename\") VALUES ('20171107070239_create_answers_test_questions.rb')"
self << "INSERT INTO \"schema_migrations\" (\"filename\") VALUES ('20171218145857_create_education_levels.rb')"
self << "INSERT INTO \"schema_migrations\" (\"filename\") VALUES ('20171218150100_create_education_levels_participants.rb')"
self << "INSERT INTO \"schema_migrations\" (\"filename\") VALUES ('20180424111102_create_explainer_categories.rb')"
self << "INSERT INTO \"schema_migrations\" (\"filename\") VALUES ('20180424111103_create_explainers.rb')"
self << "INSERT INTO \"schema_migrations\" (\"filename\") VALUES ('20180424111108_create_explainer_texts.rb')"
self << "INSERT INTO \"schema_migrations\" (\"filename\") VALUES ('20180424111120_create_explainer_images.rb')"
self << "INSERT INTO \"schema_migrations\" (\"filename\") VALUES ('20180424111512_create_explainer_texts_explainers.rb')"
self << "INSERT INTO \"schema_migrations\" (\"filename\") VALUES ('20180424111520_create_explainer_images_explainers.rb')"
self << "INSERT INTO \"schema_migrations\" (\"filename\") VALUES ('20180424111608_create_explainers_statements.rb')"
self << "INSERT INTO \"schema_migrations\" (\"filename\") VALUES ('20180425095446_create_answers_questions.rb')"
self << "INSERT INTO \"schema_migrations\" (\"filename\") VALUES ('20180425103904_create_funders.rb')"
self << "INSERT INTO \"schema_migrations\" (\"filename\") VALUES ('20180425103909_create_researchers.rb')"
self << "INSERT INTO \"schema_migrations\" (\"filename\") VALUES ('20180601093814_create_age_ranges.rb')"
self << "INSERT INTO \"schema_migrations\" (\"filename\") VALUES ('20180601093954_create_age_ranges_participants.rb')"
                end
              end
