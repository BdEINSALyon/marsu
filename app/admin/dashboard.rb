ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do

    # Here is an example of a simple dashboard with columns and panels.
    #
    columns do
      column do
        panel t('admin.dashboard.current_situation') do
          div line_chart(Student.members.group_by_day('students.updated_at').count)
        end
      end

      column do
        panel "WEI" do
          wei = Wei.current
          para wei.name
          para t('admin.dashboard.wei.registered_students', n: wei.validated_registrations.count)
          para t('admin.dashboard.wei.waiting_students', n: wei.waiting_registrations.count)
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
