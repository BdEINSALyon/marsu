
$ ->
  OTHERS = _.where(MARSU.departments, {code:'OTHER'})[0]
  PC = _.where(MARSU.departments, {code:'PC'})[0]
  TC = _.where(MARSU.departments, {code:'TC'})[0]
  check = () ->
    dep = _.where(MARSU.departments, {id:$('#student_department_id').val()})[0]
    year = _.where(MARSU.study_years, {id:$('#student_study_year_id').val()})[0]
    if parseInt(year.year) > 12
      $("#student_department_id option[value=#{OTHERS.id}]").prop('disabled', false)
      _.each(MARSU.departments, (dep) ->
        $("#student_department_id option[value=#{dep.id}]").prop('disabled', true) unless dep.code == 'OTHER'
      )
      $('#student_department_id').val(OTHERS.id)
      return
    if year.year in ['0','1','2']
      $("#student_department_id option[value=#{PC.id}]").prop('disabled', false)
      _.each(MARSU.departments, (dep) ->
        $("#student_department_id option[value=#{dep.id}]").prop('disabled', true) unless dep.code == 'PC'
      )
      if dep.code != 'PC'
        $('#student_department_id').val(PC.id)
    else
      $("#student_department_id option[value=#{PC.id}]").prop('disabled', true)
      _.each(MARSU.departments, (dep) ->
        $("#student_department_id option[value=#{dep.id}]").prop('disabled', false) unless dep.code == 'PC'
      )
      if dep.code in ['PC', 'OTHER']
        $('#student_department_id').val(TC.id)
    $("#student_department_id option[value=#{OTHERS.id}]").prop('disabled', true)

  if $('#student_department_id').length > 0
    $('form:contains(#student_department_id)').submit ()->
      $('#student_department_id').prop('disabled', false)

    $('#student_department_id').change check
    $('#student_study_year_id').change check
    check()
