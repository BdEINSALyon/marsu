ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do

    # Here is an example of a simple dashboard with columns and panels.
    #
    columns do
      column do
        panel t('admin.dashboard.current_situation') do
          div column_chart(
                  StudyYear.order(:year).where(year: 0..10).map {|year| [year.name, Student.members.where(study_year: year).count]}
                  .push([t('other_students'), Student.members.where(study_year: StudyYear.order(:year).where(year: 10..16)).count])
                  .push([t('others'), Student.members.where(study_year: StudyYear.order(:year).where(year: 16..30)).count])
                  )
          p
          div column_chart(
                  Department.active.order(:name).where.not(code:'OTHER').map {|dep| [dep.code, Student.members.where(department: dep).count]}
              )
          p
          div line_chart(Payment.for_memberships.where(created_at: 1.week.ago..Time.now).group_by_day('payments.created_at').count)
          p
          div line_chart(Payment.for_memberships.where(created_at: 1.day.ago..Time.now).group_by_hour('payments.created_at').count) if Payment.for_memberships.where(created_at: 1.day.ago..Time.now).count > 0
        end
      end

      column do
        if Wei.current
          panel "WEI" do
            wei = Wei.current
            para wei.name
            para t('admin.dashboard.wei.registered_students', n: wei.validated_registrations.count)
            para t('admin.dashboard.wei.waiting_students', n: wei.waiting_registrations.count)
          end
        end
        panel "Recent Students" do
          ul do
            Student.order(:updated_at).reverse_order.limit(5).map do |student|
              li link_to(student.name, student_path(student))
            end
          end
        end
      end
    end
  end # content
end
