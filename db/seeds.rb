
User.destroy_all
Meme.destroy_all


User.create(name: "Taimur", email: "taimurmshah@gmail.com")

Meme.create(
  title: "Elon",
  url: "https://fm.cnbc.com/applications/cnbc.com/resources/img/editorial/2018/09/07/105438875-1536336503523screen-shot-2018-09-07-at-12.07.32-pm.1910x1000.jpg",
  user_id: User.find_by(name: "Taimur").id
)

Meme.create(
  title: "Neil",
  url: "https://ametia.files.wordpress.com/2014/03/neil-degrasse-tyson.jpg",
  user_id: User.find_by(name: "Taimur").id
)

Meme.create(
  title: "Neil",
  url: "https://ametia.files.wordpress.com/2014/03/neil-degrasse-tyson.jpg",
  user_id: User.find_by(name: "Taimur").id
)
