module EventsHelper
  def event_expired?(event)
    if event.datetime < Time.now
      content_tag(:span, t("event.event_expired"), class: "badge badge-danger")
    end
  end
end
