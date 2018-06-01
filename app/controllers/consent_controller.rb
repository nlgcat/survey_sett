class ConsentController < ApplicationController
  def index
    @name               = 'Types of Information Recalled from a Paragraph'
    @errors             = error_types
    @checked            = @errors
    @participant        = current_participant
    @statements         = statements @name
    @agree_button_text  = agree_button_text
    @native             = params[:native]
    @gender             = params[:gender]
    @age_range          = params[:age_range]
    @genders            = Gender.all
    @age_ranges         = AgeRange.all

    unless @participant.consented?
      @attempted_consent = attempted_consent?
      if consent? 
        @errors.each do |k,v|
          @participant.add_consent_statement ConsentStatement.find(statement_name: k.to_s) if v == true
        end
        @participant.native = (params[:native] == 'Yes')
        @participant.gender = Gender.find(id: @gender)
        @participant.age_range = Gender.find(id: @age_range)
        @participant.save
      end
    end

    if @participant.consented?
      redirect_to '/instructions'
    end
  end

  def consent?
    error_types.each do |_k, v|
      return false unless v
    end
    return false unless Gender.find(id: @gender)
    return false unless AgeRange.find(id: @age_range)
    %w(Yes No).include? params[:native]
  end

  def agree_button_text
    'I agree to participate'
  end

  def attempted_consent?
    params[:commit] == agree_button_text
  end

  def error_types
    result = {}
    e = {}

    ConsentStatement.all.each do |consent_statement|
      e[consent_statement.statement_name.to_sym]= false
    end

    e.each do |k,v|
      result[k]=v
      if params[k]
        consent =  params[k] == '1' ? true : false
        result[k] = consent
      end
    end
    result
  end

  def statements name
    s = {}
    ConsentStatement.all.each do |consent_statement|
      s[consent_statement.statement_name.to_sym] = consent_statement.text
    end
    s
  end
end
