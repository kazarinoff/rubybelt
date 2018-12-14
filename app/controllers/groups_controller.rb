class GroupsController < ApplicationController
  def index
    unless (session[:user_id])
      redirect_to login_path and return
    else
      @user=User.find(session[:user_id])
      @groups=Group.all.includes(:members)
      @membercount=Member.group(:group_id).count
      @isamember=@user.members.group(:group_id).count
      puts @isamember, '$$$$$$$$$$$$$$$$$$4'
    end
  end

  def show
    @group=Group.find(params['id'])
    @members=@group.members.all
    @user=User.find(session[:user_id])
    if (Member.where(group:@group,user:@user).first)
      @isamember=true
    else
      @isamember=false
    end
  end

  def create
    @user=User.find(session[:user_id])
    @group = Group.new(params.require(:group).permit(:name, :description))
    @group.user=@user
    if @group.save
      Member.create(user:@user,group:@group)
      redirect_to groups_index_path and return
    else
      flash[:notice] = @group.errors.messages
      redirect_to groups_index_path and return
    end
  end

  def edit
  end

  def destroy
    unless session[:user_id]=params[:group]['user_id']
      render text: "You aren't authorized to disband this group" and return
    else
      @group=Group.find(params[:group]['id'])
      @group.delete
      redirect_to groups_index_path and return
    end
  end
end
