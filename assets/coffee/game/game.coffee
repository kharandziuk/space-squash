# game class
Game = (stage, anim, foregroundLayer, player, opponent, ball) ->
  @stage = stage
  @anim = anim
  @foregroundLayer = foregroundLayer
  @level = 1
  @player = player
  @opponent = opponent
  @ball = ball
  @scoreMessages = new Array()
  @running = false
  @turn = 1 # 1: player, 0: opponent
  @over = false

Game::stop = ->
  @running = false
  @anim.stop()

Game::start = ->
  this_ = this
  @running = true
  console.log "anim start"
  @anim.start()

Game::levelUp = ->
  fl = @foregroundLayer
  message = new Kinetic.Text(
    x: 350
    y: 300
    fontSize: 15
    fontFamily: "Calibri"
    text: "Level Up"
    textFill: "white"
  )
  @scoreMessages.push message
  @foregroundLayer.add message
  @ball.levelUp @player
  @player.levelUp 100 * @level, this
  @level += 1
  @turn = 1
  @opponent.levelUp()

  # this.resume(this.player.attrs.x + 15);
  @resume @player.move(x: 15)

Game::lifeLost = ->
  if @player.lives > 0
    @player.lifeLost()
    message = new Kinetic.Text(
      x: 350
      y: 300
      fontSize: 15
      fontFamily: "Calibri"
      text: "-1 life"
      textFill: "white"
    )
    @scoreMessages.push message
    @foregroundLayer.add message
  @opponent.lifeLost()
  @ball.lifeLost @opponent
  @turn = 0
  @resume()

Game::resume = ->
  unless @player.lives > 0
    @stop()
    for i of @scoreMessages
      @foregroundLayer.remove @scoreMessages[i]
    mbg = new Kinetic.Rect(
      x: 260
      y: 250
      width: 300
      height: 120
      fill: "#666"
      alpha: 0.9
    )
    message = new Kinetic.Text(
      x: 350
      y: 285
      fontSize: 14
      fontFamily: "Calibri"
      text: "GAME OVER"
      textFill: "white"
    )
    restart = new Kinetic.Text(
      x: 320
      y: 310
      fontSize: 13
      fontFamily: "Calibri"
      text: "press <F5> to restart"
      textFill: "white"
    )
    $("#score").val @player.points
    $("#highscoreform").overlay
      load: true
      mask:
        color: "black"

    @over = true
    @foregroundLayer.add mbg
    @foregroundLayer.add message
    @foregroundLayer.add restart