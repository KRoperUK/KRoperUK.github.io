require "stringex"
class Jekyll < Thor
  desc "post", "create a new post"
  method_option :editor, :default => "code"
  def post(*title)
    title = title.join(" ")
    date = Time.now.strftime('%Y-%m-%d')
    filename = "_posts/#{date}-#{title.to_url}.markdown"

    if File.exist?(filename)
      abort("#{filename} already exists!")
    end

    puts "Creating new post: #{filename}"
    open(filename, 'w') do |post|
      post.puts "---"
      post.puts "layout: post"
      post.puts "title: \"#{title.gsub(/&/,'&amp;')}\""
      post.puts "date: #{date}"
      post.puts "tags: general"
      post.puts "description: # Generated post"
      post.puts "categories: general"
      post.puts ""
      post.puts "---"
    end

    system(options[:editor], filename)
  end
end

class Jekyll < Thor
    desc "news", "create a new news post"
    method_option :editor, :default => "code"
    def news(*title)
      title = title.join(" ")
      date = Time.now.strftime('%Y-%m-%d')
      
      number = 1

      filename = "_news/announcement_#{number}.markdown"

      while File.exist?(filename)
        number += 1
        filename = "_news/announcement_#{number}.markdown"
      end
  
      puts "Creating new news post: #{filename}"
      open(filename, 'w') do |post|
        post.puts "---"
        post.puts "layout: post"
        post.puts "title: \"#{title.gsub(/&/,'&amp;')}\""
        post.puts "inline: true"
        post.puts "related_posts: false"
        post.puts "date: #{date}"
        post.puts "tags:"
        post.puts ""
        post.puts "---"
        post.puts ""
        post.puts "#{title.gsub(/&/,'&amp;')}"
        post.puts "<!-- Generated announcement -->"
      end
  
      system(options[:editor], filename)
    end
  end