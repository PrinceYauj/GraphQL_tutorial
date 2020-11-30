# frozen_string_literal: true

p 'seeding the DB:'

p Byg::Models::User.create(name: 'MeK', email: 'mek@wide.com', karma: 1)
p Byg::Models::User.create(name: 'MyK', email: 'MyK@small.net', karma: 5)
p Byg::Models::User.create(name: 'Kri', email: 'Kri@fat.ua', karma: -10)

p Byg::Models::Blog.create(user_id: 1,\
                           name: 'Наука и техника')
p Byg::Models::Blog.create(user_id: 2,\
                           name: 'Elementary maths')
p Byg::Models::Blog.create(user_id: 3,\
                           name: 'Aerospace engineering')
p Byg::Models::Blog.create(user_id: 3,\
                           name: 'My cooking recipes')

p Byg::Models::Post.create(blog_id: 1,\
                           text: 'Влияние диоксида циркония на свойства керамики')
p Byg::Models::Post.create(blog_id: 2,\
                           text: 'The Lebesgue integral extends the integral to a larger class of'\
  ' functions')
p Byg::Models::Post.create(blog_id: 3,\
                           text: 'Unsymmetrical dimethylhydrazine is highly toxic')
p Byg::Models::Post.create(blog_id: 4,\
                           text: 'To cook a borsch u\'ll need...')

p Byg::Models::Comment.create(user_id: 2,\
                              post_id: 1, text: 'No russian please', karma: 50)

p Byg::Models::Comment.create(user_id: 1,\
                              post_id: 4, text: 'Ваш рецепт - плохой. Готовил по нему, получилось плохо.'\
  ' Не могли, как в Crusis сделать!', karma: -200)

p Byg::Models::Reaction.create(user_id: 3, comment_id: 1, value: 1)
p Byg::Models::Reaction.create(user_id: 1, comment_id: 1, value: -1)

p Byg::Models::Reaction.create(user_id: 1, comment_id: 2, value: 1)
p Byg::Models::Reaction.create(user_id: 2, comment_id: 2, value: -1)
p Byg::Models::Reaction.create(user_id: 3, comment_id: 2, value: -1)

# 10.times { |i| Byg::Models::User.create(name: "USER#{i}", email: "EMAIL#{i}@a.uk") }
# 10.times { |i| Byg::Models::Reaction.create(user_id: 4 + i, comment_id: 1, value: [-1, -1, 1].sample) }
# 10.times { |i| Byg::Models::Reaction.create(user_id: 4 + i, comment_id: 2, value: [-1, 1, 1].sample) }
