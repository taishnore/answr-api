
User.destroy_all
Meme.destroy_all
Game.destroy_all
Round.destroy_all


@prompts = [
  "Worst gift to bring to a funeral?",
  "Avi's deep and dark secret?",
  "I drink to forget ____",
  "Douchey custom license plate",
  "Greatest pickup line?",

 ]

User.create(name: "Taimur", email: "taimurmshah@gmail.com")

Meme.create(
  title: "Elon",
  url: "https://fm.cnbc.com/applications/cnbc.com/resources/img/editorial/2018/09/07/105438875-1536336503523screen-shot-2018-09-07-at-12.07.32-pm.1910x1000.jpg",
  user_id: User.find_by(name: "Taimur")
)

Meme.create(
  title: "Neil",
  url: "https://ametia.files.wordpress.com/2014/03/neil-degrasse-tyson.jpg",
  user_id: User.find_by(name: "Taimur")
)

Game.create(title: "The Game of Life and Death", number_of_rounds: 3)
Round.create(game_id: Game.find_by(title: "The Game of Life and Death").id, prompt: @prompts.sample)
Round.create(game_id: Game.find_by(title: "The Game of Life and Death").id, prompt: @prompts.sample)
Round.create(game_id: Game.find_by(title: "The Game of Life and Death").id, prompt: @prompts.sample)
