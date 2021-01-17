module ActivitiesHelper
  def activity_owner(activity)
    activity.owner.try(:email) ? activity.owner.email : activity.owner.name
  end
end
