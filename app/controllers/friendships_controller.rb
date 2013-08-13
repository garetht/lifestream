class FriendshipsController < ApplicationController

  before_filter :authenticate_user!

  def create
    to_friend = User.find_by_email(params[:friendship][:email])
    # Render error if cannot find user by that email.
    unless to_friend
    end

    @waiting = Friendship.find_by_friend_id_and_user_id(current_user.id,
                                                       to_friend.id)
    # If there is an opposite waiting friend request,
    # confirm the friendship.
    if @waiting
      @waiting.update_attributes(friend_status: "confirmed")
      @present = Friendship.find_by_user_id_and_friend_id(current_user.id,
                                                       to_friend.id)
      @present.update_attributes(friend_status: "confirmed")

      if request.xhr?
        render @present
      else
        respond_to do |format|
          format.json {render json: @waiting}
        end
      end
      return
    end

    # If there is not, create friendships on both sides.
    @request = Friendship.new(user_id: current_user.id, 
                             friend_id: to_friend.id,
                             friend_status: "requested")
    @request.save
    @pending = Friendship.new(user_id: to_friend.id,
                              friend_id: current_user.id,
                              friend_status: "pending")
    @pending.save
      if request.xhr?
        render @request
      else
        respond_to do |format|
          format.json {render json: @request}
        end
      end
  end

  def confirm
    
  end

  def destroy
  end

  def index
    @friends = current_user.confirmed_friends
    @pending_requests = current_user.requested_friends
    @pending_friends = current_user.pending_friends
  end
end
