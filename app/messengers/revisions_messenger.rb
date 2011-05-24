class RevisionsMessenger < RedmineMessenger::Base

  unless defined?(Redmine::I18n)
    include MessengerI18nPatch
  end

  register_handler :revs do |cmd|
    cmd.group :issues
    cmd.param :issue_id, :type => :integer, :required => true
  end

  def revs(messenger, params = {})
    if issue = Issue.find_by_id(params[:issue_id])
      resp = ""
      issue.changesets.each do |changeset|
        resp << "r#{changeset.revision} by #{changeset.user} at #{changeset.commit_date}\n"
        resp << "#{Setting.protocol}://#{Setting.host_name}/projects/#{changeset.repository.project.identifier}/repository/revisions/#{changeset.revision}\n\n"
        resp << changeset.comments
        resp << "\n\n\n"
      end
      resp
    else
      l(:messenger_command_issue_not_found)
    end
  end


end
