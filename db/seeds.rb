# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Create Users
first_user = User.new(name: 'Tom', photo: 'https://images.unsplash.com/photo-1508921912186-1d1a45ebb3c1?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80', bio: 'Teacher from Mexico.', email: 'example1@email.com', password: '123456')
second_user = User.new(name: 'Lilly', photo: 'https://images.unsplash.com/photo-1530365508419-012585d6aba4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDV8fHxlbnwwfHx8fHw%3D&auto=format&fit=crop&w=500&q=60', bio: 'Teacher from Poland.', email: 'example2@email.com', password: '123456')
third_user = User.new(name: 'James', photo: 'https://images.unsplash.com/photo-1642978276901-29ef66b39ebc?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDExfHx8ZW58MHx8fHx8&auto=format&fit=crop&w=500&q=60', bio: 'Teacher from Argentina.', email: 'example3@email.com', password: '123456')
fourth_user = User.new(name: 'Laura', photo: 'https://images.unsplash.com/photo-1508922088233-a07c9cc6972f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDF8fHxlbnwwfHx8fHw%3D&auto=format&fit=crop&w=500&q=60', bio: 'Teacher from Bolivia.', email: 'example4@email.com', password: '123456')

first_user.save!
second_user.save!
third_user.save!
fourth_user.save!

# Create Posts
first_post = Post.new(author: first_user, title: 'Hello', text: 'This is my first post')
second_post = Post.new(author: first_user, title: 'Update', text: 'This is my second post')
third_post = Post.new(author: first_user, title: 'Cheers', text: 'This is my third post')
fourth_post = Post.new(author: first_user, title: 'Hey', text: 'This is my fourth post')

first_post.save!
second_post.save!
third_post.save!
fourth_post.save!

# Update users' posts_counter
User.find_each do |user|
  user.update(posts_counter: user.posts.count)
end
# Create Post Comments
begin
  Comment.create!(post: first_post, author: second_user, text: 'Hi Tom!')
  Comment.create!(post: first_post, author: third_user, text: 'Nice')
  Comment.create!(post: first_post, author: fourth_user, text: 'Congratulations')
  Comment.create!(post: first_post, author: first_user, text: 'Excellent')
  Comment.create!(post: first_post, author: second_user, text: 'Good job')
  Comment.create!(post: first_post, author: third_user, text: 'Like it')

  Comment.create!(post: fourth_post, author: fourth_user, text: 'Test1')
  Comment.create!(post: fourth_post, author: fourth_user, text: 'Test2')
  Comment.create!(post: fourth_post, author: fourth_user, text: 'Test3')
  Comment.create!(post: fourth_post, author: fourth_user, text: 'Test4')
  Comment.create!(post: fourth_post, author: fourth_user, text: 'Test5')
  Comment.create!(post: fourth_post, author: fourth_user, text: 'Test6')

rescue ActiveRecord::RecordInvalid => e
  puts "Error creating comment: #{e.message}"
end
# Create Post Likes

Like.create(post: fourth_post, author: first_user)
Like.create(post: fourth_post, author: second_user)
Like.create(post: fourth_post, author: third_user)
Like.create(post: fourth_post, author: fourth_user)

# Update comments_counter for each post
Post.find_each do |post|
  post.update(comments_counter: post.comments.count)
end

# Update likes_counter for each post
Post.find_each do |post|
  post.update(likes_counter: post.likes.count)
end

# Find a user by Name

find_user = User.find_by(name: 'Laura')
puts "User #{find_user.name} found"

# Update a user's name

find_user.update(name: 'Laura Cardigans')
puts "User #{find_user.name} updated"

# Find a post by ID

find_post = Post.find(1)
puts "#{find_post.title} found and says #{find_post.text}"

# Update post attributes
find_post.title = 'New Title'
find_post.save
puts "The post title has change to #{find_post.title}"

# Find and Delete a Comment
find_comment = find_post.comments.find_by(text: 'Nice') if find_post
puts "Comment Text: #{find_comment.text}"
puts "Coment Count before deletion: #{find_post.comments.count}"

# Create Custom Methods

# Users: method that returns the 3 most recent posts for a given user.

returns_the_three_most_recent_posts = first_user.returns_the_three_most_recent_posts
puts "Last posts for user #{first_user.name}"
returns_the_three_most_recent_posts.each do |post|
  puts "Post #{post.id} | #{post.title} | #{post.text}"
end

# Posts: method that updates the posts counter for a user.
puts "Posts counter for user #{first_user.name}: #{first_user.posts_counter}"

# Posts: method which returns the 5 most recent comments for a given post.
commented_post = fourth_post
five_most_recent_comments = commented_post.five_most_recent_comments

puts "Five most recent comments in '#{fourth_post.title}' post by '#{fourth_post.author.name}' for the user '#{find_user.name}':"
five_most_recent_comments.each do |comment|
  puts "Comment #{comment.id} | #{comment.text}"
end

# Comments: a method that updates the comments counter for a post.

puts "There are #{commented_post.comments_counter} comments for '#{commented_post.title}'"

# Likes: a method that updates the likes counter for a post.

puts "There are #{commented_post.likes_counter} likes for '#{commented_post.title}'"
