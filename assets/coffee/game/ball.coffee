# ball class
Ball = ->
  config =
    radius: 10
    fill: "white"
    x: 75
    y: 330

  Kinetic.Circle.call this, config
  @speed = 4
  @regularSpeed = 4
  @direction =
    x: -1
    y: -1

  return

Ball:: = new Kinetic.Circle({})
Ball::constructor = Ball

Ball::changePosition = (game, player, opponent) ->
  if @attrs.x <= 0
    game.lifeLost()
  else if @attrs.x >= 800
    game.levelUp()
  else if @speed > 0 and @attrs.y <= 0 or @speed > 0 and @attrs.y >= 600
    @direction.y = @direction.y * (-1)
  else if @speed > 0 and player.intersects(@getPosition()) or @speed > 0 and opponent.intersects(@getPosition())

    # $('#ping')[0].play();
    @direction.x = @direction.x * (-1)
    if player.intersects(@getPosition())
      player.score 10 * game.level, game

      # this.attrs.x += 15;
      @move x: 15
    else

      # this.attrs.x -= 15;
      @move x: -15
  else @setOnPlayerPosition player  if @speed is 0 and game.turn is 1

  # this.attrs.x += this.speed * this.direction.x;
  @move x: @speed * @direction.x

  # this.attrs.y += this.speed * this.direction.y;
  @move y: @speed * @direction.y
  return

Ball::start = ->
  @speed = @regularSpeed
  return

Ball::stop = ->
  @speed = 0
  return

Ball::setOnPlayerPosition = (side) ->
  if side.name is "Player"
    x = 25
  else
    x = -10
  x = side.getPosition().x + x
  y = side.getPosition().y + 30
  @setPosition
    x: x
    y: y

  return

Ball::levelUp = (player) ->
  @speed += 1
  @regularSpeed += 1
  @stop()
  @setOnPlayerPosition player
  return

Ball::lifeLost = (opponent) ->
  @stop()
  @setOnPlayerPosition opponent
  return