desc 'Assign posts to a first user!'
task assign_post: :environment do
  user = User.first
  Post.update_all(user_id: user.id)
end