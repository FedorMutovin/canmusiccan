module FollowsHelper
  def resource_class_name(resource)
    resource.class.name.underscore
  end
end
