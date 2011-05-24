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
        resp << ("r%s by %s at %s\n" % [changeset.revision, changeset.user, changeset.commit_date])
        resp << ("%s://%s/projects/%s/repository/revisions/%s\n\n" % [Setting.protocol, Setting.host_name, changeset.repository.project.identifier, changeset.revision])
        resp << changeset.comments
        resp << "\n\n\n"
      end
      resp
    else
      l(:messenger_command_issue_not_found)
    end
  end


end
