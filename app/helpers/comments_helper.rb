module CommentsHelper
  
   def find_user_name(comment)
    id = comment.user_id
    user = User.find(id)
    return user.name
  end
end
