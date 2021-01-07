module ApplicationHelper
  def flash_class_style(flash_type)
    flash_type.eql?('alert') ? 'alert-danger' : 'alert-info'
  end
end
