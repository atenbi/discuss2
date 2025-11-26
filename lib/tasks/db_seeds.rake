namespace :db do
  desc "Seeds forum data"
  task seed_forum: :environment do
    puts "Seeding Forum Users..."
    forum_users.each do |attrs|
      User.find_or_create_by!(id: attrs[:id]) do |user|
        user.username = attrs[:username]
        user.email = attrs[:email]
        random_password = SecureRandom.alphanumeric(rand(6..10))
        user.password = random_password
        user.password_confirmation = random_password
        user.created_at = attrs[:created_at]
        user.updated_at = attrs[:updated_at]
        user.confirmed_at = Time.current
        user.skip_confirmation!
      end
      print "."
    end

    puts "\nSeeding Forum Categories..."
    forum_categories.each do |attrs|
      Forum::Category.find_or_create_by!(id: attrs[:id]) do |category|
        category.name = attrs[:name]
        category.slug = attrs[:slug]
        category.bg_color = attrs[:bg_color]
        category.created_at = attrs[:created_at]
        category.updated_at = attrs[:updated_at]
      end
      print "."
    end

    puts "\nSeeding Forum Tags..."
    forum_tags.each do |attrs|
      Forum::Tag.find_or_create_by!(id: attrs[:id]) do |tag|
        tag.name = attrs[:name]
        tag.slug = attrs[:slug]
        tag.created_at = attrs[:created_at]
        tag.updated_at = attrs[:updated_at]
      end
      print "."
    end

    puts "\nSeeding Forum Topics..."
    forum_topics.each do |attrs|
      Forum::Topic.find_or_create_by!(id: attrs[:id]) do |topic|
        topic.user_id = attrs[:user_id]
        topic.category_id = attrs[:category_id]
        topic.num_views = attrs[:num_views]
        topic.title = attrs[:title]
        topic.slug = attrs[:slug]
        topic.created_at = attrs[:created_at]
        topic.updated_at = attrs[:updated_at]
        topic.active_at = attrs[:active_at]
        topic.content = attrs[:content]
      end
      print "."
    end

    puts "\nSeeding Forum Posts..."
    forum_posts.each do |attrs|
      Forum::Post.find_or_create_by!(id: attrs[:id]) do |post|
        post.user_id = attrs[:user_id]
        post.topic_id = attrs[:topic_id]
        post.content = attrs[:content]
        post.created_at = attrs[:created_at]
        post.updated_at = attrs[:updated_at]
      end
      print "."
    end

    puts "\nAssigning tags to forum topics..."
    forum_taggables.each do |attrs|
      Forum::Taggable.find_or_create_by!(
        topic_id: attrs[:topic_id],
        tag_id: attrs[:tag_id]
      ) do |taggable|
        taggable.created_at = attrs[:created_at]
        taggable.updated_at = attrs[:updated_at]
      end
      print "."
    end

    puts "\nForum data seeded successfully!"
  end

  def forum_users
    [
      { id: 1, username: "Brian Brown", email: "jessicamitchell@grant.com", created_at: "2025-01-24T02:03:40", updated_at: "2025-02-26T15:20:41" },
      { id: 2, username: "Jennifer Whitaker", email: "shannonmoore@hotmail.com", created_at: "2025-01-18T16:45:52", updated_at: "2025-02-01T15:50:09" },
      { id: 3, username: "Carla Harper", email: "yleon@gmail.com", created_at: "2025-03-20T21:19:50", updated_at: "2025-02-22T19:39:59" },
      { id: 4, username: "Kaitlyn Glover", email: "sarah90@gmail.com", created_at: "2025-02-20T04:29:48", updated_at: "2025-02-16T14:58:01" },
      { id: 5, username: "Curtis Silva MD", email: "davidhaynes@yahoo.com", created_at: "2025-02-04T12:10:26", updated_at: "2025-01-01T10:17:39" },
      { id: 6, username: "Carlos Alexander", email: "audrey07@yahoo.com", created_at: "2025-01-11T20:42:33", updated_at: "2025-03-11T09:09:32" },
      { id: 7, username: "Jimmy Green", email: "heidicisneros@yahoo.com", created_at: "2025-02-07T02:34:10", updated_at: "2025-01-20T10:08:35" },
      { id: 8, username: "John Hill", email: "xchambers@hotmail.com", created_at: "2025-01-06T13:25:42", updated_at: "2025-01-21T16:59:44" },
      { id: 9, username: "Justin West", email: "michaelcampos@yahoo.com", created_at: "2025-03-07T04:30:33", updated_at: "2025-02-19T08:03:32" },
      { id: 10, username: "Brenda Finley", email: "rhodeskrystal@ryan-williams.com", created_at: "2025-03-06T05:29:45", updated_at: "2025-02-13T18:56:00" },
      { id: 11, username: "Julie Castillo MD", email: "ryangonzalez@gmail.com", created_at: "2025-03-22T06:55:35", updated_at: "2025-01-06T16:34:02" },
      { id: 12, username: "Kelsey Adams", email: "kimrobert@ramirez.com", created_at: "2025-02-14T02:56:08", updated_at: "2025-02-24T15:34:54" },
      { id: 13, username: "Thomas Rodriguez", email: "jacobwang@lindsey.com", created_at: "2025-01-11T16:55:53", updated_at: "2025-01-16T09:01:02" },
      { id: 14, username: "Melissa Mcconnell", email: "richardmooney@yahoo.com", created_at: "2025-01-30T23:06:27", updated_at: "2025-01-25T04:17:12" },
      { id: 15, username: "Frederick Nelson", email: "parrishcharles@smith.com", created_at: "2025-01-18T19:46:58", updated_at: "2025-01-12T19:50:07" },
      { id: 16, username: "Johnathan Weaver", email: "karenstewart@hotmail.com", created_at: "2025-02-20T01:20:38", updated_at: "2025-03-21T16:51:01" },
      { id: 17, username: "Christopher Flowers", email: "amandaacosta@reyes.info", created_at: "2025-02-16T18:57:55", updated_at: "2025-01-01T02:50:01" },
      { id: 18, username: "Monica Maldonado", email: "kjohnson@branch-wright.com", created_at: "2025-03-29T12:09:01", updated_at: "2025-02-17T13:30:09" },
      { id: 19, username: "Patrick Chung", email: "mollymccarthy@gilbert-garcia.com", created_at: "2025-03-14T18:59:18", updated_at: "2025-02-24T17:23:03" },
      { id: 20, username: "Jodi Blankenship", email: "phillipsbreanna@johnson.com", created_at: "2025-03-19T22:00:04", updated_at: "2025-03-29T08:48:08" },
      { id: 21, username: "Anna Evans", email: "palmerjacqueline@hotmail.com", created_at: "2025-03-27T10:22:17", updated_at: "2025-02-26T12:30:25" },
      { id: 22, username: "Cathy Ali", email: "hector44@hotmail.com", created_at: "2025-03-28T02:20:35", updated_at: "2025-03-02T12:32:37" },
      { id: 23, username: "Russell Wright", email: "christina65@briggs.com", created_at: "2025-03-11T11:39:06", updated_at: "2025-01-03T16:01:27" },
      { id: 24, username: "Jane Martinez", email: "rwilliams@hotmail.com", created_at: "2025-03-30T20:15:25", updated_at: "2025-02-11T23:04:40" },
      { id: 25, username: "Amy Romero", email: "allenpaula@richards.com", created_at: "2025-01-13T10:30:43", updated_at: "2025-01-29T00:43:12" },
      { id: 26, username: "William Torres", email: "veronicaaguilar@gmail.com", created_at: "2025-02-14T15:56:53", updated_at: "2025-03-20T21:02:55" },
      { id: 27, username: "Shelly Lang", email: "kevinwhite@yahoo.com", created_at: "2025-03-25T01:02:28", updated_at: "2025-03-17T18:46:00" },
      { id: 28, username: "Bryan Rogers", email: "elizabethdunn@yahoo.com", created_at: "2025-02-11T10:14:17", updated_at: "2025-02-21T04:19:31" },
      { id: 29, username: "Robert Pope", email: "ohall@hunt-ibarra.org", created_at: "2025-02-17T18:35:37", updated_at: "2025-03-10T11:40:47" },
      { id: 30, username: "Raymond Bowen", email: "robert72@yahoo.com", created_at: "2025-03-23T13:52:22", updated_at: "2025-03-08T13:23:06" },
      { id: 31, username: "Dr. Seth Baker MD", email: "kevinlarsen@yahoo.com", created_at: "2025-03-17T12:20:52", updated_at: "2025-01-03T15:52:31" },
      { id: 32, username: "Joshua Clay", email: "irobinson@gmail.com", created_at: "2025-01-29T16:24:18", updated_at: "2025-03-25T13:23:29" },
      { id: 33, username: "Kristy Clark", email: "howardjoshua@hotmail.com", created_at: "2025-01-31T03:45:43", updated_at: "2025-01-29T23:16:02" },
      { id: 34, username: "Mr. Patrick Ramirez", email: "ubennett@berry.com", created_at: "2025-03-29T23:28:54", updated_at: "2025-03-22T13:01:25" },
      { id: 35, username: "Jessica Goodwin", email: "matthewmosley@gmail.com", created_at: "2025-02-24T20:07:51", updated_at: "2025-03-09T13:15:34" },
      { id: 36, username: "Chelsea Moore", email: "knightvickie@yahoo.com", created_at: "2025-01-21T04:34:11", updated_at: "2025-01-09T23:48:55" },
      { id: 37, username: "Rebecca Foster", email: "xwalker@hotmail.com", created_at: "2025-03-05T10:43:24", updated_at: "2025-03-21T02:14:00" },
      { id: 38, username: "Roberta Hernandez", email: "zwilson@yahoo.com", created_at: "2025-03-19T10:41:40", updated_at: "2025-02-13T12:06:34" },
      { id: 39, username: "Brian Leach", email: "monique82@gmail.com", created_at: "2025-03-23T10:56:36", updated_at: "2025-01-08T09:24:23" },
      { id: 40, username: "John Duke", email: "xgallagher@yahoo.com", created_at: "2025-02-13T00:35:37", updated_at: "2025-03-19T15:48:14" },
      { id: 41, username: "Andrew Welch", email: "harrisonemily@barnes.info", created_at: "2025-04-02T04:05:10", updated_at: "2025-03-12T10:49:01" },
      { id: 42, username: "Jacob Turner", email: "edward00@collier.com", created_at: "2025-03-23T10:52:43", updated_at: "2025-04-02T07:27:57" },
      { id: 43, username: "Julie Diaz", email: "jessicatorres@gmail.com", created_at: "2025-01-08T02:45:00", updated_at: "2025-02-04T23:48:04" },
      { id: 44, username: "Ronald Brown", email: "darlene63@yahoo.com", created_at: "2025-03-21T06:30:39", updated_at: "2025-03-22T11:01:36" },
      { id: 45, username: "John Cardenas", email: "sarahgarcia@singleton-brown.com", created_at: "2025-03-25T12:24:26", updated_at: "2025-02-07T17:53:38" },
      { id: 46, username: "Emily Robertson", email: "sara18@mitchell-khan.com", created_at: "2025-01-27T17:55:22", updated_at: "2025-04-02T05:36:09" },
      { id: 47, username: "Brandi Mills", email: "christinaglass@yahoo.com", created_at: "2025-01-30T22:22:14", updated_at: "2025-01-07T14:07:24" },
      { id: 48, username: "Carmen Sawyer", email: "omeyers@gmail.com", created_at: "2025-01-19T05:55:49", updated_at: "2025-02-13T21:43:06" },
      { id: 49, username: "Ryan Hernandez", email: "gstone@yahoo.com", created_at: "2025-01-11T19:09:41", updated_at: "2025-01-26T22:11:10" },
      { id: 50, username: "Kenneth Harris", email: "srodriguez@yahoo.com", created_at: "2025-01-15T12:51:36", updated_at: "2025-02-25T07:44:31" }
    ]
  end

  def forum_categories
    [
      { id: 1, name: "AI News & Trends", slug: "ai-news-trends", bg_color: "#bebd8d", created_at: "2025-02-10T01:23:59", updated_at: "2025-03-10T15:39:51" },
      { id: 2, name: "Machine Learning", slug: "machine-learning", bg_color: "#31856f", created_at: "2025-01-11T15:59:08", updated_at: "2025-03-16T20:16:58" },
      { id: 3, name: "Natural Language Processing", slug: "natural-language-processing", bg_color: "#c21699", created_at: "2025-02-14T08:26:12", updated_at: "2025-02-04T21:53:44" },
      { id: 4, name: "Computer Vision", slug: "computer-vision", bg_color: "#7abfe2", created_at: "2025-01-26T02:17:10", updated_at: "2025-01-18T18:08:56" },
      { id: 5, name: "AI Ethics & Safety", slug: "ai-ethics-safety", bg_color: "#8a1d72", created_at: "2025-01-26T16:51:50", updated_at: "2025-02-12T05:58:47" },
      { id: 6, name: "Robotics & Automation", slug: "robotics-automation", bg_color: "#9e8806", created_at: "2025-03-17T10:12:30", updated_at: "2025-02-10T02:57:20" },
      { id: 7, name: "AI Tools & Frameworks", slug: "ai-tools-frameworks", bg_color: "#0baf5d", created_at: "2025-01-09T13:25:22", updated_at: "2025-02-18T23:12:01" },
      { id: 8, name: "Generative AI", slug: "generative-ai", bg_color: "#5eade5", created_at: "2025-01-31T13:13:04", updated_at: "2025-01-24T00:11:34" }
    ]
  end

  def forum_tags
    [
      { id: 1, name: "deep learning", slug: "deep-learning", created_at: "2025-02-14T13:26:26", updated_at: "2025-03-04T17:08:52" },
      { id: 2, name: "transformers", slug: "transformers", created_at: "2025-03-22T12:39:11", updated_at: "2025-02-12T03:23:39" },
      { id: 3, name: "computer vision", slug: "computer-vision", created_at: "2025-01-17T17:40:25", updated_at: "2025-03-01T22:15:36" },
      { id: 4, name: "nlp", slug: "nlp", created_at: "2025-02-27T08:03:22", updated_at: "2025-03-22T19:53:59" },
      { id: 5, name: "openai", slug: "openai", created_at: "2025-01-21T14:41:35", updated_at: "2025-03-18T07:11:33" },
      { id: 6, name: "chatbots", slug: "chatbots", created_at: "2025-02-03T06:35:28", updated_at: "2025-02-05T00:22:20" },
      { id: 7, name: "data science", slug: "data-science", created_at: "2025-03-05T23:46:40", updated_at: "2025-01-28T17:10:45" },
      { id: 8, name: "neural networks", slug: "neural-networks", created_at: "2025-01-16T10:29:43", updated_at: "2025-02-13T23:03:25" },
      { id: 9, name: "reinforcement learning", slug: "reinforcement-learning", created_at: "2025-01-22T08:45:49", updated_at: "2025-03-12T19:55:52" },
      { id: 10, name: "prompt engineering", slug: "prompt-engineering", created_at: "2025-03-22T08:40:35", updated_at: "2025-01-19T11:34:18" },
      { id: 11, name: "llms", slug: "llms", created_at: "2025-03-23T20:04:54", updated_at: "2025-02-24T22:27:32" },
      { id: 12, name: "autoencoders", slug: "autoencoders", created_at: "2025-02-11T21:35:07", updated_at: "2025-02-10T09:36:19" },
      { id: 13, name: "mlops", slug: "mlops", created_at: "2025-03-08T02:04:46", updated_at: "2025-02-14T18:03:03" },
      { id: 14, name: "bias & fairness", slug: "bias-fairness", created_at: "2025-01-16T04:00:03", updated_at: "2025-01-08T10:14:01" },
      { id: 15, name: "ai startups", slug: "ai-startups", created_at: "2025-04-01T05:15:08", updated_at: "2025-03-26T23:09:54" },
      { id: 16, name: "ethics", slug: "ethics", created_at: "2025-03-30T01:17:46", updated_at: "2025-02-06T19:11:30" },
      { id: 17, name: "gpt", slug: "gpt", created_at: "2025-01-20T23:11:58", updated_at: "2025-02-10T07:11:33" },
      { id: 18, name: "fine-tuning", slug: "fine-tuning", created_at: "2025-01-01T12:59:42", updated_at: "2025-01-05T19:10:38" },
      { id: 19, name: "speech recognition", slug: "speech-recognition", created_at: "2025-02-03T11:52:05", updated_at: "2025-01-20T00:45:52" },
      { id: 20, name: "edge ai", slug: "edge-ai", created_at: "2025-03-14T02:35:58", updated_at: "2025-02-06T17:42:47" },
      { id: 21, name: "vision transformers", slug: "vision-transformers", created_at: "2025-02-26T04:23:44", updated_at: "2025-03-29T08:49:58" },
      { id: 22, name: "generative ai", slug: "generative-ai", created_at: "2025-03-19T11:03:53", updated_at: "2025-03-24T05:27:36" },
      { id: 23, name: "data labeling", slug: "data-labeling", created_at: "2025-03-24T16:01:34", updated_at: "2025-03-31T02:58:53" },
      { id: 24, name: "dataset curation", slug: "dataset-curation", created_at: "2025-02-09T17:57:50", updated_at: "2025-02-13T01:57:43" },
      { id: 25, name: "ai regulation", slug: "ai-regulation", created_at: "2025-03-16T00:53:43", updated_at: "2025-02-14T15:17:02" }
    ]
  end

  def forum_topics
    [
      { id: 1, user_id: 30, category_id: 7, num_views: 541, title: "Best open-source tools for training models?", slug: "best-open-source-tools-for-training-models", created_at: "2025-11-26T07:59:44", updated_at: "2025-11-26T14:05:49", active_at: "2025-11-26T14:05:49", content: "What are the most reliable and beginner-friendly tools for training AI/ML models locally or in the cloud?" },
      { id: 2, user_id: 27, category_id: 1, num_views: 984, title: "Latest breakthroughs in generative AI", slug: "latest-breakthroughs-in-generative-ai", created_at: "2025-11-24T00:20:48", updated_at: "2025-11-27T16:02:44", active_at: "2025-11-27T16:02:44", content: "What are some of the most impressive advancements in generative AI this year? Any exciting research or demos?" },
      { id: 3, user_id: 31, category_id: 5, num_views: 156, title: "Can AI be truly ethical?", slug: "can-ai-be-truly-ethical", created_at: "2025-11-25T14:25:00", updated_at: "2025-11-25T19:42:55", active_at: "2025-11-25T19:42:55", content: "Ethical AI is trending, but can we ever create systems free of bias and discrimination?" },
      { id: 4, user_id: 34, category_id: 6, num_views: 54, title: "AI in robotics: promising or overhyped?", slug: "ai-in-robotics-promising-or-overhyped", created_at: "2025-11-24T00:24:22", updated_at: "2025-11-25T17:55:21", active_at: "2025-11-25T17:55:21", content: "With all the recent robotics demos, are we close to real-world AI robots or is it mostly marketing?" },
      { id: 5, user_id: 41, category_id: 4, num_views: 181, title: "What's the best dataset for object detection?", slug: "best-dataset-for-object-detection", created_at: "2025-11-25T10:49:45", updated_at: "2025-11-25T15:33:42", active_at: "2025-11-25T15:33:42", content: "I'm building a computer vision model—what datasets are most commonly used for training on object detection tasks?" },
      { id: 6, user_id: 22, category_id: 8, num_views: 673, title: "Cool generative AI experiments worth trying?", slug: "cool-generative-ai-experiments-worth-trying", created_at: "2025-09-06T20:17:33", updated_at: "2025-09-06T20:17:33", active_at: "2025-09-06T20:17:33", content: "Looking to explore some fun or creative use cases for generative AI—any recommendations for tools or prompts?" },
      { id: 7, user_id: 39, category_id: 5, num_views: 564, title: "What are alignment problems in AI?", slug: "what-are-alignment-problems-in-ai", created_at: "2025-09-07T15:18:44", updated_at: "2025-09-07T15:18:44", active_at: "2025-09-07T15:18:44", content: "I keep seeing 'alignment' come up in safety discussions. Can someone explain what alignment means in this context?" },
      { id: 8, user_id: 24, category_id: 2, num_views: 174, title: "Best ML model for time series prediction?", slug: "best-ml-model-for-time-series-prediction", created_at: "2025-09-08T20:55:15", updated_at: "2025-09-08T20:55:15", active_at: "2025-09-08T20:55:15", content: "What are the current best practices or models (transformers?) for accurate time-series forecasting?" },
      { id: 9, user_id: 34, category_id: 1, num_views: 374, title: "Will AI replace software engineers?", slug: "will-ai-replace-software-engineers", created_at: "2025-09-09T23:11:34", updated_at: "2025-09-09T23:11:34", active_at: "2025-09-09T23:11:34", content: "With tools like GitHub Copilot and GPTs improving, is coding going to become obsolete?" },
      { id: 10, user_id: 34, category_id: 2, num_views: 952, title: "Training large models on a budget?", slug: "training-large-models-on-a-budget", created_at: "2025-11-26T15:33:22", updated_at: "2025-11-26T22:18:12", active_at: "2025-11-26T22:18:12", content: "Is it feasible to train your own transformer-based model without cloud costs spiraling? Tips for low-cost compute?" },
      { id: 11, user_id: 40, category_id: 6, num_views: 683, title: "Most impressive AI robots of 2025?", slug: "most-impressive-ai-robots-of-2025", created_at: "2025-11-26T18:32:05", updated_at: "2025-11-27T02:47:18", active_at: "2025-11-27T02:47:18", content: "Which humanoid or task-specific robots are actually delivering useful results today?" },
      { id: 12, user_id: 27, category_id: 3, num_views: 586, title: "Best language models for summarization?", slug: "best-language-models-for-summarization", created_at: "2025-11-26T06:20:14", updated_at: "2025-11-26T18:33:29", active_at: "2025-11-26T18:33:29", content: "Looking to deploy an NLP model that can condense long texts accurately. What models or APIs should I explore?" },
      { id: 13, user_id: 48, category_id: 8, num_views: 123, title: "How are artists using AI today?", slug: "how-are-artists-using-ai-today", created_at: "2025-11-12T07:37:19", updated_at: "2025-11-12T15:28:33", active_at: "2025-11-12T15:28:33", content: "Curious about how visual and music artists are integrating AI into their work—any standout examples?" },
      { id: 14, user_id: 10, category_id: 7, num_views: 832, title: "What's your AI dev setup?", slug: "whats-your-ai-dev-setup", created_at: "2025-11-13T00:17:31", updated_at: "2025-11-13T13:55:22", active_at: "2025-11-13T13:55:22", content: "What environment and tools do you use for AI/ML development? From local setups to cloud stacks." },
      { id: 15, user_id: 37, category_id: 4, num_views: 66, title: "How to evaluate a computer vision model?", slug: "how-to-evaluate-a-computer-vision-model", created_at: "2025-11-14T11:45:33", updated_at: "2025-11-14T19:42:29", active_at: "2025-11-14T19:42:29", content: "What metrics should I use to properly evaluate the performance of my computer vision model?" },
      { id: 16, user_id: 45, category_id: 3, num_views: 298, title: "Transformer architecture explained?", slug: "transformer-architecture-explained", created_at: "2025-09-16T09:12:18", updated_at: "2025-09-16T09:12:18", active_at: "2025-09-16T09:12:18", content: "Can someone break down how transformers work in simple terms? I understand the basics but want to go deeper." },
      { id: 17, user_id: 12, category_id: 1, num_views: 445, title: "AI regulation updates 2025", slug: "ai-regulation-updates-2025", created_at: "2025-09-17T14:30:22", updated_at: "2025-09-17T14:30:22", active_at: "2025-09-17T14:30:22", content: "What are the latest regulatory developments affecting AI development and deployment?" },
      { id: 18, user_id: 33, category_id: 8, num_views: 712, title: "Text-to-image model comparison", slug: "text-to-image-model-comparison", created_at: "2025-09-18T16:45:11", updated_at: "2025-09-18T16:45:11", active_at: "2025-09-18T16:45:11", content: "Which text-to-image models are currently the best for different use cases? DALL-E, Midjourney, Stable Diffusion?" },
      { id: 19, user_id: 28, category_id: 2, num_views: 189, title: "Feature engineering best practices", slug: "feature-engineering-best-practices", created_at: "2025-09-19T08:22:44", updated_at: "2025-09-19T08:22:44", active_at: "2025-09-19T08:22:44", content: "What are the most effective techniques for feature engineering in machine learning projects?" },
      { id: 20, user_id: 15, category_id: 5, num_views: 367, title: "AI bias in hiring algorithms", slug: "ai-bias-in-hiring-algorithms", created_at: "2025-09-20T12:15:33", updated_at: "2025-09-20T12:15:33", active_at: "2025-09-20T12:15:33", content: "How can we detect and mitigate bias in AI systems used for recruitment and hiring?" },
      { id: 21, user_id: 42, category_id: 6, num_views: 523, title: "Autonomous vehicle progress update", slug: "autonomous-vehicle-progress-update", created_at: "2025-09-21T19:40:17", updated_at: "2025-09-21T19:40:17", active_at: "2025-09-21T19:40:17", content: "What's the current state of autonomous vehicle technology? Are we getting closer to full self-driving?" },
      { id: 22, user_id: 7, category_id: 7, num_views: 634, title: "MLOps tools comparison 2025", slug: "mlops-tools-comparison-2025", created_at: "2025-09-22T10:33:29", updated_at: "2025-09-22T10:33:29", active_at: "2025-09-22T10:33:29", content: "What are the best MLOps platforms and tools available today? Looking for production-ready solutions." },
      { id: 23, user_id: 19, category_id: 4, num_views: 278, title: "Real-time object tracking techniques", slug: "real-time-object-tracking-techniques", created_at: "2025-09-23T15:28:41", updated_at: "2025-09-23T15:28:41", active_at: "2025-09-23T15:28:41", content: "What are the most effective algorithms for real-time object tracking in video streams?" },
      { id: 24, user_id: 36, category_id: 3, num_views: 456, title: "Large language model fine-tuning", slug: "large-language-model-fine-tuning", created_at: "2025-09-24T13:52:16", updated_at: "2025-09-24T13:52:16", active_at: "2025-09-24T13:52:16", content: "How do you fine-tune large language models for specific domains? What are the key considerations?" },
      { id: 25, user_id: 50, category_id: 1, num_views: 789, title: "AI startup funding trends", slug: "ai-startup-funding-trends", created_at: "2025-09-25T11:18:55", updated_at: "2025-09-25T11:18:55", active_at: "2025-09-25T11:18:55", content: "What are investors looking for in AI startups right now? Any notable funding rounds or trends?" },
      { id: 26, user_id: 26, category_id: 8, num_views: 345, title: "AI music generation tools", slug: "ai-music-generation-tools", created_at: "2025-11-26T09:45:22", updated_at: "2025-11-26T19:42:17", active_at: "2025-11-26T19:42:17", content: "What are the best AI tools for generating music? Looking for both commercial and open-source options." }
    ]
  end

  def forum_posts
    [
      { id: 1, user_id: 15, topic_id: 1, content: "I've been using PyTorch Lightning for most of my projects. It's really beginner-friendly and has great documentation.", created_at: "2025-11-26T09:10:12", updated_at: "2025-11-26T09:10:12" },
      { id: 2, user_id: 22, topic_id: 1, content: "Hugging Face Transformers is also excellent, especially if you're working with NLP models. The model hub is incredible.", created_at: "2025-11-26T11:22:37", updated_at: "2025-11-26T11:22:37" },
      { id: 3, user_id: 35, topic_id: 1, content: "Don't forget about TensorFlow 2.x - it's much more user-friendly now and has great Keras integration.", created_at: "2025-11-26T14:05:49", updated_at: "2025-11-26T14:05:49" },
      { id: 4, user_id: 8, topic_id: 2, content: "The recent advances in diffusion models have been mind-blowing. DALL-E 3 and Midjourney v6 are producing photorealistic results.", created_at: "2025-11-26T18:33:21", updated_at: "2025-11-26T18:33:21" },
      { id: 5, user_id: 31, topic_id: 2, content: "Don't forget about the progress in video generation! Runway and Pika Labs are creating some amazing content.", created_at: "2025-11-24T10:15:33", updated_at: "2025-11-24T10:15:33" },
      { id: 6, user_id: 19, topic_id: 2, content: "Stable Diffusion XL has been a game-changer for open-source image generation. The quality is incredible.", created_at: "2025-11-25T13:47:18", updated_at: "2025-11-25T13:47:18" },
      { id: 7, user_id: 42, topic_id: 2, content: "I'm particularly excited about the real-time generation capabilities we're starting to see.", created_at: "2025-11-27T16:02:44", updated_at: "2025-11-27T16:02:44" },
      { id: 8, user_id: 44, topic_id: 3, content: "This is such an important question. I think we need to focus on transparency and explainability in AI systems.", created_at: "2025-11-25T15:10:44", updated_at: "2025-11-25T15:10:44" },
      { id: 9, user_id: 17, topic_id: 3, content: "The challenge is that bias often reflects the data we train on. We need better data curation and diverse teams.", created_at: "2025-11-25T16:25:18", updated_at: "2025-11-25T16:25:18" },
      { id: 10, user_id: 29, topic_id: 3, content: "Regular auditing and testing for bias should be mandatory for AI systems used in critical applications.", created_at: "2025-11-25T19:42:55", updated_at: "2025-11-25T19:42:55" },
      { id: 11, user_id: 29, topic_id: 4, content: "I think we're still in the early stages. Most demos are impressive but not ready for real-world deployment.", created_at: "2025-11-24T01:15:37", updated_at: "2025-11-24T01:15:37" },
      { id: 12, user_id: 41, topic_id: 4, content: "Boston Dynamics and Tesla are making real progress though. The applications in manufacturing are already showing results.", created_at: "2025-11-24T02:30:55", updated_at: "2025-11-24T02:30:55" },
      { id: 13, user_id: 16, topic_id: 4, content: "The key challenge is making robots that can handle unexpected situations and edge cases safely.", created_at: "2025-11-25T08:45:12", updated_at: "2025-11-25T08:45:12" },
      { id: 14, user_id: 33, topic_id: 4, content: "I'm excited about collaborative robots (cobots) that can work alongside humans in various industries.", created_at: "2025-11-25T13:22:38", updated_at: "2025-11-25T13:22:38" },
      { id: 15, user_id: 48, topic_id: 4, content: "The cost factor is still a major barrier for widespread adoption in smaller businesses.", created_at: "2025-11-25T17:55:21", updated_at: "2025-11-25T17:55:21" },
      { id: 16, user_id: 13, topic_id: 5, content: "COCO dataset is still the gold standard for object detection. It's comprehensive and well-annotated.", created_at: "2025-11-25T11:20:33", updated_at: "2025-11-25T11:20:33" },
      { id: 17, user_id: 37, topic_id: 5, content: "For specific domains, you might want to look at Open Images or create your own dataset with tools like Roboflow.", created_at: "2025-11-25T12:45:17", updated_at: "2025-11-25T12:45:17" },
      { id: 18, user_id: 25, topic_id: 5, content: "ImageNet is also crucial for classification tasks, though it's showing its age in some areas.", created_at: "2025-11-25T15:33:42", updated_at: "2025-11-25T15:33:42" },
      { id: 19, user_id: 25, topic_id: 6, content: "I've been experimenting with ChatGPT for creative writing prompts. The results are surprisingly good for brainstorming.", created_at: "2025-09-06T21:30:44", updated_at: "2025-09-06T21:30:44" },
      { id: 20, user_id: 48, topic_id: 6, content: "Try using DALL-E for concept art generation. It's great for rapid prototyping of visual ideas.", created_at: "2025-09-06T22:15:22", updated_at: "2025-09-06T22:15:22" },
      { id: 21, user_id: 14, topic_id: 6, content: "AI-assisted music composition tools like AIVA and Amper are opening up new creative possibilities.", created_at: "2025-09-06T23:48:15", updated_at: "2025-09-06T23:48:15" },
      { id: 22, user_id: 39, topic_id: 6, content: "The key is using AI as a collaborator rather than a replacement for human creativity.", created_at: "2025-09-07T02:12:33", updated_at: "2025-09-07T02:12:33" },
      { id: 23, user_id: 11, topic_id: 7, content: "Alignment refers to ensuring AI systems pursue the goals we actually want them to pursue, not just what we think we're telling them.", created_at: "2025-09-07T16:45:11", updated_at: "2025-09-07T16:45:11" },
      { id: 24, user_id: 39, topic_id: 7, content: "It's about the difference between what we specify and what we actually want. Classic example: asking for paperclips and getting the universe converted to paperclips.", created_at: "2025-09-07T17:20:33", updated_at: "2025-09-07T17:20:33" },
      { id: 25, user_id: 27, topic_id: 7, content: "The challenge becomes even more complex as AI systems become more capable and autonomous.", created_at: "2025-09-07T20:15:47", updated_at: "2025-09-07T20:15:47" },
      { id: 26, user_id: 32, topic_id: 8, content: "For time series, I've had great success with Temporal Fusion Transformers. They handle multiple time series really well.", created_at: "2025-09-08T21:40:28", updated_at: "2025-09-08T21:40:28" },
      { id: 27, user_id: 24, topic_id: 8, content: "Don't overlook traditional methods like ARIMA or Prophet for simpler cases. Sometimes they outperform complex models.", created_at: "2025-09-08T22:25:44", updated_at: "2025-09-08T22:25:44" },
      { id: 28, user_id: 18, topic_id: 8, content: "LSTM and GRU networks are still very effective for many time series prediction tasks.", created_at: "2025-09-09T01:33:17", updated_at: "2025-09-09T01:33:17" },
      { id: 29, user_id: 45, topic_id: 8, content: "Feature engineering is crucial - domain knowledge often beats fancy algorithms.", created_at: "2025-09-09T09:18:52", updated_at: "2025-09-09T09:18:52" },
      { id: 30, user_id: 18, topic_id: 9, content: "I think AI will augment rather than replace engineers. We'll become more productive, but human creativity and problem-solving remain crucial.", created_at: "2025-09-10T00:30:17", updated_at: "2025-09-10T00:30:17" },
      { id: 31, user_id: 34, topic_id: 9, content: "The key is to adapt and learn to work with AI tools. Those who embrace them will have a significant advantage.", created_at: "2025-09-10T01:15:55", updated_at: "2025-09-10T01:15:55" },
      { id: 32, user_id: 41, topic_id: 9, content: "AI is already transforming how we write code, debug, and design systems. The future is collaborative.", created_at: "2025-09-10T05:42:28", updated_at: "2025-09-10T05:42:28" },
      { id: 33, user_id: 46, topic_id: 10, content: "Look into gradient checkpointing and mixed precision training. These can significantly reduce memory usage.", created_at: "2025-11-26T16:20:11", updated_at: "2025-11-26T16:20:11" },
      { id: 34, user_id: 34, topic_id: 10, content: "Also consider using cloud spot instances or preemptible VMs. They're much cheaper but require fault-tolerant training setups.", created_at: "2025-11-26T17:45:33", updated_at: "2025-11-26T17:45:33" },
      { id: 35, user_id: 21, topic_id: 10, content: "Model parallelism and data parallelism can help distribute the computational load across multiple GPUs.", created_at: "2025-11-26T19:33:45", updated_at: "2025-11-26T19:33:45" },
      { id: 36, user_id: 38, topic_id: 10, content: "Don't forget about quantization techniques - they can significantly reduce model size and inference time.", created_at: "2025-11-26T22:18:12", updated_at: "2025-11-26T22:18:12" },
      { id: 37, user_id: 23, topic_id: 11, content: "The potential applications in healthcare are enormous - from drug discovery to personalized treatment plans.", created_at: "2025-11-26T19:15:22", updated_at: "2025-11-26T19:15:22" },
      { id: 38, user_id: 47, topic_id: 11, content: "Climate modeling and environmental monitoring could benefit greatly from advanced AI systems.", created_at: "2025-11-26T21:33:45", updated_at: "2025-11-26T21:33:45" },
      { id: 39, user_id: 31, topic_id: 11, content: "Education could be revolutionized with personalized AI tutors and adaptive learning systems.", created_at: "2025-11-27T02:47:18", updated_at: "2025-11-27T02:47:18" },
      { id: 40, user_id: 28, topic_id: 12, content: "Transfer learning has been a game-changer. You can achieve great results with relatively small datasets now.", created_at: "2025-11-26T07:22:33", updated_at: "2025-11-26T07:22:33" },
      { id: 41, user_id: 35, topic_id: 12, content: "Pre-trained models like BERT and GPT have made NLP much more accessible to smaller teams.", created_at: "2025-11-26T09:45:17", updated_at: "2025-11-26T09:45:17" },
      { id: 42, user_id: 16, topic_id: 12, content: "The key is knowing when to fine-tune vs when to use the pre-trained model as-is.", created_at: "2025-11-26T14:18:52", updated_at: "2025-11-26T14:18:52" },
      { id: 43, user_id: 44, topic_id: 12, content: "Domain adaptation techniques are crucial when your data differs significantly from the pre-training data.", created_at: "2025-11-26T18:33:29", updated_at: "2025-11-26T18:33:29" },
      { id: 44, user_id: 32, topic_id: 13, content: "Prompt engineering is becoming an art form. The right prompt can make or break your results.", created_at: "2025-11-12T08:15:44", updated_at: "2025-11-12T08:15:44" },
      { id: 45, user_id: 49, topic_id: 13, content: "Chain-of-thought prompting has been particularly effective for complex reasoning tasks.", created_at: "2025-11-12T11:42:17", updated_at: "2025-11-12T11:42:17" },
      { id: 46, user_id: 22, topic_id: 13, content: "Few-shot learning with good examples in the prompt can often outperform fine-tuning.", created_at: "2025-11-12T15:28:33", updated_at: "2025-11-12T15:28:33" },
      { id: 47, user_id: 41, topic_id: 14, content: "MLflow has been my go-to for experiment tracking. It integrates well with most ML frameworks.", created_at: "2025-11-13T00:25:18", updated_at: "2025-11-13T00:25:18" },
      { id: 48, user_id: 27, topic_id: 14, content: "Weights & Biases offers excellent visualization and collaboration features for team projects.", created_at: "2025-11-13T03:47:33", updated_at: "2025-11-13T03:47:33" },
      { id: 49, user_id: 15, topic_id: 14, content: "Don't overlook TensorBoard - it's simple but effective for basic experiment tracking.", created_at: "2025-11-13T08:12:45", updated_at: "2025-11-13T08:12:45" },
      { id: 50, user_id: 38, topic_id: 14, content: "Neptune.ai has some advanced features for model versioning and collaboration.", created_at: "2025-11-13T13:55:22", updated_at: "2025-11-13T13:55:22" },
      { id: 51, user_id: 19, topic_id: 15, content: "Precision, recall, and F1-score are the basics, but you need to consider your specific use case.", created_at: "2025-11-14T12:33:17", updated_at: "2025-11-14T12:33:17" },
      { id: 52, user_id: 43, topic_id: 15, content: "For object detection, mAP (mean Average Precision) is the standard metric across different IoU thresholds.", created_at: "2025-11-14T15:18:44", updated_at: "2025-11-14T15:18:44" },
      { id: 53, user_id: 26, topic_id: 15, content: "Don't forget about inference speed and model size - they're crucial for production deployment.", created_at: "2025-11-14T19:42:29", updated_at: "2025-11-14T19:42:29" },
      { id: 54, user_id: 33, topic_id: 16, content: "The attention mechanism is the key innovation. It allows the model to focus on relevant parts of the input.", created_at: "2025-09-16T10:25:33", updated_at: "2025-09-16T10:25:33" },
      { id: 55, user_id: 18, topic_id: 16, content: "Self-attention enables parallel processing, which makes transformers much faster to train than RNNs.", created_at: "2025-09-16T13:47:18", updated_at: "2025-09-16T13:47:18" },
      { id: 56, user_id: 29, topic_id: 16, content: "The positional encoding is crucial for understanding sequence order since there's no inherent ordering.", created_at: "2025-09-16T17:33:45", updated_at: "2025-09-16T17:33:45" },
      { id: 57, user_id: 41, topic_id: 16, content: "Multi-head attention allows the model to attend to different types of relationships simultaneously.", created_at: "2025-09-16T21:15:22", updated_at: "2025-09-16T21:15:22" },
      { id: 58, user_id: 24, topic_id: 17, content: "The EU AI Act is setting the global standard for AI regulation. Other regions are following suit.", created_at: "2025-09-17T15:42:18", updated_at: "2025-09-17T15:42:18" },
      { id: 59, user_id: 36, topic_id: 17, content: "Risk-based classification is becoming the norm - high-risk AI systems face stricter requirements.", created_at: "2025-09-17T18:25:44", updated_at: "2025-09-17T18:25:44" },
      { id: 60, user_id: 47, topic_id: 17, content: "Documentation and audit trails are becoming mandatory for many AI applications.", created_at: "2025-09-17T22:18:33", updated_at: "2025-09-17T22:18:33" },
      { id: 61, user_id: 28, topic_id: 18, content: "For photorealism, Midjourney still leads, but DALL-E 3 has better prompt adherence.", created_at: "2025-09-18T17:33:22", updated_at: "2025-09-18T17:33:22" },
      { id: 62, user_id: 15, topic_id: 18, content: "Stable Diffusion XL is the best open-source option - you can run it locally and customize it.", created_at: "2025-09-18T19:47:15", updated_at: "2025-09-18T19:47:15" },
      { id: 63, user_id: 42, topic_id: 18, content: "Adobe Firefly is great for commercial use since it's trained only on licensed content.", created_at: "2025-09-18T22:15:38", updated_at: "2025-09-18T22:15:38" },
      { id: 64, user_id: 31, topic_id: 18, content: "The choice depends on your specific needs: speed, quality, customization, or commercial licensing.", created_at: "2025-09-19T01:28:44", updated_at: "2025-09-19T01:28:44" },
      { id: 65, user_id: 37, topic_id: 19, content: "Domain knowledge is crucial. Understanding your data is more important than fancy algorithms.", created_at: "2025-09-19T09:15:33", updated_at: "2025-09-19T09:15:33" },
      { id: 66, user_id: 44, topic_id: 19, content: "Automated feature selection can help, but manual feature engineering often yields better results.", created_at: "2025-09-19T12:42:17", updated_at: "2025-09-19T12:42:17" },
      { id: 67, user_id: 21, topic_id: 19, content: "Don't forget about feature scaling and normalization - they can make or break your model performance.", created_at: "2025-09-19T16:33:45", updated_at: "2025-09-19T16:33:45" },
      { id: 68, user_id: 32, topic_id: 20, content: "Algorithmic auditing should be standard practice. We need systematic approaches to detect bias.", created_at: "2025-09-20T13:22:18", updated_at: "2025-09-20T13:22:18" },
      { id: 69, user_id: 49, topic_id: 20, content: "Diverse hiring teams and inclusive data collection are the first steps toward fair AI systems.", created_at: "2025-09-20T16:45:33", updated_at: "2025-09-20T16:45:33" },
      { id: 70, user_id: 23, topic_id: 20, content: "Fairness metrics like demographic parity and equalized odds should be part of model evaluation.", created_at: "2025-09-20T19:18:47", updated_at: "2025-09-20T19:18:47" },
      { id: 71, user_id: 38, topic_id: 20, content: "Regular monitoring and retraining are essential as bias can creep in over time.", created_at: "2025-09-20T22:33:22", updated_at: "2025-09-20T22:33:22" },
      { id: 72, user_id: 27, topic_id: 21, content: "Level 4 autonomy is still the goal for most companies. We're making progress but it's slower than expected.", created_at: "2025-09-21T20:25:44", updated_at: "2025-09-21T20:25:44" },
      { id: 73, user_id: 35, topic_id: 21, content: "The sensor technology has improved dramatically - LiDAR, cameras, and radar are all getting better and cheaper.", created_at: "2025-09-21T22:47:18", updated_at: "2025-09-21T22:47:18" },
      { id: 74, user_id: 16, topic_id: 21, content: "Edge cases and safety validation remain the biggest challenges for widespread deployment.", created_at: "2025-09-22T02:15:33", updated_at: "2025-09-22T02:15:33" },
      { id: 75, user_id: 43, topic_id: 22, content: "Kubeflow is excellent for Kubernetes-native ML workflows. Great for teams already using K8s.", created_at: "2025-09-22T11:18:22", updated_at: "2025-09-22T11:18:22" },
      { id: 76, user_id: 29, topic_id: 22, content: "MLflow is simpler to get started with and has great experiment tracking capabilities.", created_at: "2025-09-22T14:42:15", updated_at: "2025-09-22T14:42:15" },
      { id: 77, user_id: 18, topic_id: 22, content: "For cloud-native solutions, AWS SageMaker and Google Vertex AI are comprehensive platforms.", created_at: "2025-09-22T17:33:47", updated_at: "2025-09-22T17:33:47" },
      { id: 78, user_id: 46, topic_id: 22, content: "DVC (Data Version Control) is underrated for data and model versioning in MLOps pipelines.", created_at: "2025-09-22T21:25:33", updated_at: "2025-09-22T21:25:33" },
      { id: 79, user_id: 31, topic_id: 23, content: "SORT and DeepSORT are still widely used, but newer methods like FairMOT show better performance.", created_at: "2025-09-23T16:15:18", updated_at: "2025-09-23T16:15:18" },
      { id: 80, user_id: 45, topic_id: 23, content: "Kalman filters remain fundamental for motion prediction in tracking algorithms.", created_at: "2025-09-23T18:42:33", updated_at: "2025-09-23T18:42:33" },
      { id: 81, user_id: 22, topic_id: 23, content: "The key challenge is maintaining identity consistency across occlusions and appearance changes.", created_at: "2025-09-23T21:28:45", updated_at: "2025-09-23T21:28:45" },
      { id: 82, user_id: 48, topic_id: 24, content: "LoRA (Low-Rank Adaptation) is a game-changer for efficient fine-tuning of large models.", created_at: "2025-09-24T14:33:22", updated_at: "2025-09-24T14:33:22" },
      { id: 83, user_id: 26, topic_id: 24, content: "Data quality is crucial - clean, domain-specific data often matters more than quantity.", created_at: "2025-09-24T17:18:45", updated_at: "2025-09-24T17:18:45" },
      { id: 84, user_id: 39, topic_id: 24, content: "Instruction tuning and RLHF (Reinforcement Learning from Human Feedback) are essential for alignment.", created_at: "2025-09-24T20:47:18", updated_at: "2025-09-24T20:47:18" },
      { id: 85, user_id: 14, topic_id: 24, content: "Consider the computational costs - fine-tuning large models requires significant resources.", created_at: "2025-09-25T01:22:33", updated_at: "2025-09-25T01:22:33" },
      { id: 86, user_id: 41, topic_id: 25, content: "Generative AI and foundation models are attracting the most investment right now.", created_at: "2025-09-25T12:15:44", updated_at: "2025-09-25T12:15:44" },
      { id: 87, user_id: 33, topic_id: 25, content: "Investors are looking for clear paths to monetization and defensible moats in AI startups.", created_at: "2025-09-25T15:33:17", updated_at: "2025-09-25T15:33:17" },
      { id: 88, user_id: 47, topic_id: 25, content: "Enterprise AI solutions and vertical-specific applications are seeing strong funding.", created_at: "2025-09-25T18:47:22", updated_at: "2025-09-25T18:47:22" },
      { id: 89, user_id: 34, topic_id: 26, content: "Suno and Udio are leading the AI music generation space with impressive quality.", created_at: "2025-11-26T10:33:18", updated_at: "2025-11-26T10:33:18" },
      { id: 90, user_id: 21, topic_id: 26, content: "For open-source options, MusicGen by Meta and AudioCraft are worth exploring.", created_at: "2025-11-26T13:25:44", updated_at: "2025-11-26T13:25:44" },
      { id: 91, user_id: 37, topic_id: 26, content: "AIVA is great for classical and cinematic music composition with good customization options.", created_at: "2025-11-26T16:18:33", updated_at: "2025-11-26T16:18:33" },
      { id: 92, user_id: 28, topic_id: 26, content: "The key is finding tools that match your musical style and workflow preferences.", created_at: "2025-11-26T19:42:17", updated_at: "2025-11-26T19:42:17" }
    ]
  end

  def forum_taggables
    [
      { topic_id: 1, tag_id: 7, created_at: "2025-09-01T07:59:44", updated_at: "2025-09-01T07:59:44" },
      { topic_id: 1, tag_id: 1, created_at: "2025-09-01T07:59:44", updated_at: "2025-09-01T07:59:44" },
      { topic_id: 2, tag_id: 22, created_at: "2025-09-02T00:20:48", updated_at: "2025-09-02T00:20:48" },
      { topic_id: 2, tag_id: 5, created_at: "2025-09-02T00:20:48", updated_at: "2025-09-02T00:20:48" },
      { topic_id: 3, tag_id: 16, created_at: "2025-09-03T14:25:00", updated_at: "2025-09-03T14:25:00" },
      { topic_id: 3, tag_id: 14, created_at: "2025-09-03T14:25:00", updated_at: "2025-09-03T14:25:00" },
      { topic_id: 4, tag_id: 15, created_at: "2025-09-04T00:24:22", updated_at: "2025-09-04T00:24:22" },
      { topic_id: 5, tag_id: 3, created_at: "2025-09-05T10:49:45", updated_at: "2025-09-05T10:49:45" },
      { topic_id: 5, tag_id: 24, created_at: "2025-09-05T10:49:45", updated_at: "2025-09-05T10:49:45" },
      { topic_id: 6, tag_id: 22, created_at: "2025-09-06T20:17:33", updated_at: "2025-09-06T20:17:33" },
      { topic_id: 6, tag_id: 10, created_at: "2025-09-06T20:17:33", updated_at: "2025-09-06T20:17:33" },
      { topic_id: 7, tag_id: 16, created_at: "2025-09-07T15:18:44", updated_at: "2025-09-07T15:18:44" },
      { topic_id: 8, tag_id: 2, created_at: "2025-09-08T20:55:15", updated_at: "2025-09-08T20:55:15" },
      { topic_id: 8, tag_id: 7, created_at: "2025-09-08T20:55:15", updated_at: "2025-09-08T20:55:15" },
      { topic_id: 9, tag_id: 15, created_at: "2025-09-09T23:11:34", updated_at: "2025-09-09T23:11:34" },
      { topic_id: 10, tag_id: 2, created_at: "2025-09-10T15:33:22", updated_at: "2025-09-10T15:33:22" },
      { topic_id: 10, tag_id: 1, created_at: "2025-09-10T15:33:22", updated_at: "2025-09-10T15:33:22" },
      { topic_id: 11, tag_id: 15, created_at: "2025-09-11T18:32:05", updated_at: "2025-09-11T18:32:05" },
      { topic_id: 12, tag_id: 4, created_at: "2025-09-12T06:20:14", updated_at: "2025-09-12T06:20:14" },
      { topic_id: 12, tag_id: 11, created_at: "2025-09-12T06:20:14", updated_at: "2025-09-12T06:20:14" },
      { topic_id: 13, tag_id: 22, created_at: "2025-09-13T07:37:19", updated_at: "2025-09-13T07:37:19" },
      { topic_id: 14, tag_id: 7, created_at: "2025-09-14T23:17:31", updated_at: "2025-09-14T23:17:31" },
      { topic_id: 14, tag_id: 13, created_at: "2025-09-14T23:17:31", updated_at: "2025-09-14T23:17:31" },
      { topic_id: 15, tag_id: 3, created_at: "2025-09-15T11:45:33", updated_at: "2025-09-15T11:45:33" },
      { topic_id: 16, tag_id: 2, created_at: "2025-09-16T09:12:18", updated_at: "2025-09-16T09:12:18" },
      { topic_id: 16, tag_id: 4, created_at: "2025-09-16T09:12:18", updated_at: "2025-09-16T09:12:18" },
      { topic_id: 17, tag_id: 25, created_at: "2025-09-17T14:30:22", updated_at: "2025-09-17T14:30:22" },
      { topic_id: 17, tag_id: 16, created_at: "2025-09-17T14:30:22", updated_at: "2025-09-17T14:30:22" },
      { topic_id: 18, tag_id: 22, created_at: "2025-09-18T16:45:11", updated_at: "2025-09-18T16:45:11" },
      { topic_id: 19, tag_id: 7, created_at: "2025-09-19T08:22:44", updated_at: "2025-09-19T08:22:44" },
      { topic_id: 20, tag_id: 14, created_at: "2025-09-20T12:15:33", updated_at: "2025-09-20T12:15:33" },
      { topic_id: 20, tag_id: 16, created_at: "2025-09-20T12:15:33", updated_at: "2025-09-20T12:15:33" },
      { topic_id: 21, tag_id: 15, created_at: "2025-09-21T19:40:17", updated_at: "2025-09-21T19:40:17" },
      { topic_id: 22, tag_id: 13, created_at: "2025-09-22T10:33:29", updated_at: "2025-09-22T10:33:29" },
      { topic_id: 22, tag_id: 7, created_at: "2025-09-22T10:33:29", updated_at: "2025-09-22T10:33:29" },
      { topic_id: 23, tag_id: 3, created_at: "2025-09-23T15:28:41", updated_at: "2025-09-23T15:28:41" },
      { topic_id: 24, tag_id: 11, created_at: "2025-09-24T13:52:16", updated_at: "2025-09-24T13:52:16" },
      { topic_id: 24, tag_id: 18, created_at: "2025-09-24T13:52:16", updated_at: "2025-09-24T13:52:16" },
      { topic_id: 25, tag_id: 15, created_at: "2025-09-25T11:18:55", updated_at: "2025-09-25T11:18:55" },
      { topic_id: 26, tag_id: 22, created_at: "2025-09-26T09:45:22", updated_at: "2025-09-26T09:45:22" }
    ]
  end
end
