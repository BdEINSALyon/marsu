ActiveAdmin.register Student do
  menu priority: 2, id: 'Student'
  sidebar I18n.t('admin.student.payments'), only: :show do
    student.payments.each do |p|
      attributes_table_for p do
        row(:payable) { |b| link_to b.payable.name, admin_payment_path(b) }
        row(I18n.t('membership.refunded')) { |b| status_tag b.refunded }
      end
    end
  end
end