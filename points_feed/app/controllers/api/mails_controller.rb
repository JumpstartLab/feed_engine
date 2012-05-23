class Api::MailsController < ApplicationController

  def create
    subject = Sanitize::clean(params["subject"])
    body = Sanitize::clean(params["body-html"])
    sender = params["sender"]

    user = User.where(:email => sender).first

    unless user.blank?
      user.text_posts.create(:content => subject + " " + body)
      render :json => true
    else
      error(403)
    end
  end

end
