class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]

  def index
    @users = User.all
  end

  # GET /users/x8-x4-x4-x4-x12
  def show
   flash.notice = t(@user.healthy? ? 'healthy' : 'at_risk', scope: :user)
    # WIP: Link to information pack for at risk users
  end

  # GET /users/new
  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.where(nhs_number: user_params[:nhs_number]).first_or_initialize(user_params)

    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        format.html { redirect_to question_path(Question.first), notice: 'Welcome' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # :nocov:
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  # :nocov:

  def destroy
    @user.destroy!

    respond_to do |format|
      format.html { redirect_to users_path, status: :see_other, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_user
    @user = User.find(params.expect(:id))
  end

  def user_params
    params.expect(user: %i[nhs_number last_name dob])
  end
end
