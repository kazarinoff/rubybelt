class MembersController < ApplicationController
  def destroy
    unless session[:user_id]=params[:member]['user_id']
      render text: "You aren't authorized to leave this group" and return
    else
      @group=Group.find(params[:member]['group_id'])
      @member=Member.where(user_id:(params[:member]['user_id']), group:@group).first
      @member.destroy
      redirect_to groups_show_path(@group) and return
    end
  end

  def create
    unless session[:user_id]=params[:member]['user_id']
      render text: "You aren't authorized to join this group" and return
    else
      @group=Group.find(params[:member]['group_id'])
      Member.create(group:Group.find(params[:member]['group_id']),user:User.find(params[:member]['user_id']))
      redirect_to groups_show_path(@group) and return
    end
  end
end
