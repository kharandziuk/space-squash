# player class
Player = ->
  config =
    fill: "white"
    x: 50
    y: 300
    width: 15
    height: 60

  Kinetic.Rect.call this, config
  @speed = 4
  @lives = 3
  @points = 0
  @name = "Player"
  return
Player:: = new Kinetic.Rect({})
Player::constructor = Player
Player::moveDown = (playerSpeed) ->

  # this.attrs.y += this.speed;
  @move y: @speed  if @attrs.y < 570
  return

Player::moveUp = (playerSpeed) ->

  # this.attrs.y -= this.speed;
  @move y: -@speed  if @attrs.y > -30
  return

Player::moveLeft = (playerSpeed) ->

  # this.attrs.x -= this.speed;
  @move x: -@speed  if @attrs.x > 0
  return

Player::moveRight = (playerSpeed) ->

  # this.attrs.x += this.speed;
  @move x: @speed  if @attrs.x < 385
  return

Player::score = (points, game) ->
  @points += points
  scoreText = new Kinetic.Text(
    x: @attrs.x
    y: @attrs.y + 10
    text: points
    textFill: "white"
    fontFamily: "Calibri"
    fontSize: 15
  )
  game.scoreMessages.push scoreText
  game.foregroundLayer.add scoreText
  return

Player::levelUp = (points, game) ->
  @speed += 1
  @score points, game
  return

Player::lifeLost = ->
  @lives -= 1
  return