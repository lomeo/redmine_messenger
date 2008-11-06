module UserMessengerHelper
  
  def issue_status_to_select
    options = []
    options << [l(:messenger_options_statuses_dont_change, nil)]
    IssueStatus.all.each do |x| 
      name = x.name.downcase
      name = l("default_issue_status_#{name}".to_sym).downcase if l_has_string?("default_issue_status_#{name}".to_sym)
      options << [name, x.id]      
    end
    options
    
    
    
    
  end

  def notification_to_select
    UserMessenger::NOTIFICATION.collect { |x| [l("field_messenger_notifications_#{x}".to_sym), x] }
  end
  
end
