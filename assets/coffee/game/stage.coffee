initStage = ->

  # background

  # foreground

  # player

  # computer

  # ball

  # game obj

  # scoreboard

  # foregroundLayer.add(welcomeScreen);

  # key events

  # start game

  # foregroundLayer.remove(welcomeScreen);
  animOnframe = ->
    if input[40] is true or input[83] is true
      player.moveDown()
    else if input[38] is true or input[87] is true
      player.moveUp()
    else if input[37] is true or input[65] is true
      player.moveLeft()
    else player.moveRight()  if input[39] is true or input[68] is true
    opponent.changePosition game, ball
    ball.changePosition game, player, opponent
    for i of game.scoreMessages

      # game.scoreMessages[i].attrs.y -= 5;
      game.scoreMessages[i].move y: -5

    # game.scoreMessages[i].setAlpha(game.scoreMessages[i].attrs.alpha - 0.01);

    # refresh scoreboard
    textLives.attrs.text = "Lives: " + player.lives
    textLevel.attrs.text = "Level: " + game.level
    textScore.attrs.text = "Score: " + player.points
  stage = new Kinetic.Stage(
    container: "board"
    width: 800
    height: 600
  )
  backgroundLayer = new Kinetic.Layer()
  background = new Kinetic.Rect(
    fill: "black"
    x: 0
    y: 0
    width: 800
    height: 600
  )
  middleLine = new Kinetic.Group()
  y = 0

  while y <= 700
    linePart = new Kinetic.Rect(
      x: 398
      y: y
      width: 4
      height: 19.5
      fill: "white"
    )
    middleLine.add linePart
    y += 38.7
  backgroundLayer.add background
  backgroundLayer.add middleLine
  foregroundLayer = new Kinetic.Layer()
  player = new Player()
  foregroundLayer.add player
  opponent = new Opponent()
  foregroundLayer.add opponent
  ball = new Ball()
  window.ball = ball
  foregroundLayer.add ball
  anim = new Kinetic.Animation(animOnframe, foregroundLayer)
  game = new Game(stage, anim, foregroundLayer, player, opponent, ball)
  textLives = new Kinetic.Text(
    x: 0
    y: 0
    text: "Lives: " + player.lives
    textFill: "white"
    padding: 5
    fontSize: 8
  )
  foregroundLayer.add textLives
  textLevel = new Kinetic.Text(
    x: 50
    y: 0
    text: "Level :" + game.level
    textFill: "white"
    padding: 5
    fontSize: 8
  )
  foregroundLayer.add textLevel
  textScore = new Kinetic.Text(
    x: 100
    y: 0
    text: "Score: " + player.points
    textFill: "white"
    padding: 5
    fontSize: 8
  )
  foregroundLayer.add textScore
  welcomeScreen = new Kinetic.Group()
  wbg = new Kinetic.Rect(
    x: 260
    y: 230
    width: 290
    height: 120
    fill: "#666"
    alpha: 0.9
  )
  controlsHead = new Kinetic.Text(
    x: 295
    y: 245
    fontSize: 12
    fontFamily: "Calibri"
    text: "controls:"
    textFill: "white"
  )
  controls = new Kinetic.Text(
    x: 295
    y: 265
    fontSize: 12
    fontFamily: "Calibri"
    text: "use w,a,s,d or arrows to move"
    textFill: "white"
  )
  controlsBall = new Kinetic.Text(
    x: 295
    y: 285
    fontSize: 12
    fontFamily: "Calibri"
    text: "SPACE starts the ball"
    textFill: "white"
  )
  start = new Kinetic.Text(
    x: 295
    y: 315
    fontSize: 13
    fontFamily: "Calibri"
    text: "press SPACE to start game"
    textFill: "white"
  )
  welcomeScreen.add wbg
  welcomeScreen.add controlsHead
  welcomeScreen.add controls
  welcomeScreen.add controlsBall
  welcomeScreen.add start
  stage.add backgroundLayer
  stage.add foregroundLayer
  input = {}
  document.addEventListener "keydown", (e) ->
    e.preventDefault()  if game.running is true
    input[e.which] = true
    if input[32] is true and game.over is false
      e.preventDefault()
      if game.running is false
        game.start()
        game.ball.stop()
        game.ball.setOnPlayerPosition game.player
        game.ball.start()
      else
        game.ball.start()  if game.turn is 1

  document.addEventListener "keyup", (e) ->
    input[e.which] = false

$ ->
  initStage()
