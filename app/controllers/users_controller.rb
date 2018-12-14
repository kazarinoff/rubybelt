class UsersController < ApplicationController
  def new
  end

  def create
    @user = User.new(params.require(:user).permit(:first_name, :last_name, :email, :password))
    if @user.save
      session[:user_id]=User.last.id
      redirect_to groups_index_path and return
    else
      flash[:notice] = @user.errors.messages
      redirect_to login_path and return
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end
  def logincreate
    @user=User.find_by email:params['email']
    unless @user
        flash['passworderror'] = "Email was not found in database"
        redirect_to login_path and return
    end
    if @user.authenticate(params['password'])
        session[:user_id]=@user.id
        redirect_to groups_index_path and return
    else
        flash['passworderror'] = "Invalid"
        redirect_to login_path and return
    end
  end
  def logoutdestroy
    session[:user_id]=nil
    redirect_to login_path
  end

end
