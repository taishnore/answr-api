

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



Game.create(title: "The Game of Life and Death", number_of_rounds: 3, is_game_in_play: true)
Round.create(game_id: Game.find_by(title: "The Game of Life and Death").id, prompt: @prompts.sample)
Round.create(game_id: Game.find_by(title: "The Game of Life and Death").id, prompt: @prompts.sample)
Round.create(game_id: Game.find_by(title: "The Game of Life and Death").id, prompt: @prompts.sample)
