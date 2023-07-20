# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Create Users

first_user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
second_user = User.create(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Poland.')
third_user = User.create(name: 'James', photo: 'https://example.com/james.jpg', bio: 'Teacher from Argentina.')
fourth_user = User.create(name: 'Laura', photo: 'https://example.com/laura.jpg', bio: 'Teacher from Bolivia.')

# Create Posts

first_post = Post.create(author: first_user, title: 'Hello', text: 'This is my first post')
second_post = Post.create(author: first_user, title: 'Update', text: 'This is my second post')
third_post = Post.create(author: first_user, title: 'Cheers', text: 'This is my third post')
fourth_post = Post.create(author: first_user, title: 'Hey', text: 'This is my fourth post')

# Create Post Comments

Comment.create(post: first_post, author: second_user, text: 'Hi Tom!')
Comment.create(post: first_post, author: third_user, text: 'Nice')
Comment.create(post: first_post, author: fourth_user, text: 'Congratulations')
Comment.create(post: first_post, author: first_user, text: 'Excellent')
Comment.create(post: first_post, author: second_user, text: 'Good job')
Comment.create(post: first_post, author: third_user, text: 'Like it')

Comment.create(post: fourth_post, author: fourth_user, text: 'Test1')
Comment.create(post: fourth_post, author: fourth_user, text: 'Test2')
Comment.create(post: fourth_post, author: fourth_user, text: 'Test3')
Comment.create(post: fourth_post, author: fourth_user, text: 'Test4')
Comment.create(post: fourth_post, author: fourth_user, text: 'Test5')
Comment.create(post: fourth_post, author: fourth_user, text: 'Test6')

puts "#{fourth_post.comments.count} | Comments for post #{fourth_post.title} created"

# Create Post Likes

Like.create(post: fourth_post, author: first_user)
Like.create(post: fourth_post, author: second_user)
Like.create(post: fourth_post, author: third_user)
Like.create(post: fourth_post, author: fourth_user)

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
# find_comment.destroy
# puts "Coment Count after deletion: #{post.comments.count}"

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
