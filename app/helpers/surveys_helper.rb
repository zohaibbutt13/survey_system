module SurveysHelper
  def render_option(question)
    if question.question_type == 'Checkbox'
      data = '<br><input type = "checkbox">'
    elsif question.question_type == 'Radio Buttons'
      data = '<br><input type = "radio">'
    elsif question.question_type == 'Comment Box'
      data = '<br><label> Comment box: </label>'
    elsif question.question_type == 'True / False'
      data = '<br><input type = "radio">'
    end
    data.html_safe
  end

  def question_options
    ['Checkbox', 'Radio Buttons', 'Comment Box', 'True / False']
  end

  def survey_type
    ['Private', 'Public']
  end
end
