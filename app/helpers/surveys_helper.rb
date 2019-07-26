module SurveysHelper
  def render_option(question)
    if question.question_type == 'Checkbox'
      data = '<input type = "checkbox">'
    elsif question.question_type == 'Radio Buttons'
      data = '<input type = "radio">'
    elsif question.question_type == 'Comment Box'
      data = '<label> Comment box: </label>'
    elsif question.question_type == 'True / False'
      data = '<input type = "radio"><br>True<input type = "radio"/>False'
    end
    data.html_safe
  end
end
