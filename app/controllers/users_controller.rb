class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  before_filter :require_user, :except => [:rate, :game, :new, :create, :findFriends, :findInterests]
  def index
    @users = User.all
    
    @user = current_user

    # store all the ratings for this user
    
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  def findFriends

    @this_user_ratings = Rating.where("user_id = ?", current_user.id)
    @users = User.all

    @friendship_points = []

    # for all other users, calculate their friend_points
    @users.each do |other_user|

    # the higher the friend point, the more similar this user is to current_user
    friend_points = 0

      # for every rating the current user has
      @this_user_ratings.each do |current_users_rating|  

        # make sure we are not comparing the same user to himself
        if current_user.id != other_user.id

          if Rating.exists?(:user_id => other_user.id, :interest_id => current_users_rating.interest_id)
            other_users_rating = Rating.where("user_id = ? AND interest_id = ?", other_user.id, current_users_rating.interest_id).first
            friend_points += other_users_rating.rating * current_users_rating.rating
          end
        end # end if
      end # end for each rating

      @friendship_points << friend_points

    end # end for each user

    # display the user with the most friend_points
    max = 0
    max_i = 0
    @friendship_points.each_with_index do |points, index|
      if points > max
        max = points
        max_i = index + 1
      end
    end

    #@friendship_points
    # return user with the most points
    if max_i != 0
      @friend = User.find(max_i)
    else
      @friend = nil
    end
  end # end function

  def findInterests
    friend = findFriends

    @interests_in_common = []
    
    unless (friend.nil?)
      # for every interest, compare the ratings of both users
      @interests = Interest.all
      @ratings = Rating.find_by_user_id(friend.id)
      @interests.each do |current_interest|
        current_user_rating = Rating.where("user_id = ? AND interest_id = ?", current_user.id, current_interest.id).first
        other_users_rating = Rating.where("user_id = ? AND interest_id = ?", friend.id, current_interest.id).first

        if (current_user_rating.nil?)
          current_users_rating = Rating.create(user: current_user, interest: current_interest, rating: 0)
        end
        if (other_users_rating.nil?)
          other_users_rating = Rating.create(user: friend, interest: current_interest, rating: 0)
        end
        
        current_user_rating = Rating.where("user_id = ? AND interest_id = ?", current_user.id, current_interest.id).first
        other_users_rating = Rating.where("user_id = ? AND interest_id = ?", friend.id, current_interest.id).first

        if current_user_rating.rating > 0 and other_users_rating.rating > 0
            @interests_in_common << current_interest
        end

      end
    end
    return @interests_in_common 
  end

  # this is the controller that handles playing the game for the user
  def game
    @user = User.find(params[:id])
    @interests = Interest.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    #@user = User.find(params[:id]) #IF ADMIN
    @user = current_user

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    #@user = User.find(params[:id])  #IF ADMIN
    @user = current_user
  end

  def rate
    @interest = Interest.find(params[:interest_id])

    # find the user's rating that matches the interest passed in
    @rating = Rating.where("user_id = ? AND interest_id = ?", current_user.id, @interest.id).first
    @rating.rating = @rating.rating + 1
    @rating.save
  end
  # POST /users
  # POST /users.json

  def create
    @user = User.new(params[:user])
    @interests = Interest.all

    respond_to do |format|
      if @user.save
        # when you make a new user, create ratings for the user (all set to 0)
        @interests.each do |current_interest|
          current_users_rating = Rating.create(user: @user, interest: current_interest, rating: 0)
          current_users_rating.save
        end
        format.html { redirect_to(:users, :notice => 'Registration successful.') }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = current_user

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html {
          flash[:notice] = 'User was successfully updated.'
          redirect_to(:action => "edit", :id => @user.id )
        }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    #@user = User.find(params[:id]) #IF ADMIN
    @user = current_user
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
end
