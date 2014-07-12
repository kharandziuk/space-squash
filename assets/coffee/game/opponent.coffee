# opponent class
Opponent = ->
  config =
    fill: "white"
    x: 735
    y: 300
    width: 15
    height: 60

  Kinetic.Rect.call this, config
  @speed = 4
  @moveTo = `undefined`
  @name = "Opponent"
Opponent:: = new Kinetic.Rect({})
Opponent::constructor = Opponent
Opponent::changePosition = (game, ball) ->
  new_y = `undefined`

  # moving ball
  if ball.speed > 0
    if ball.attrs.x >= 425
      new_y = ball.attrs.y
    else
      new_y = 300
    if @attrs.y < new_y

      # this.attrs.y += this.speed;
      @move y: @speed

    # this.attrs.y -= this.speed;
    else @move y: -@speed  if @attrs.y > new_y

  # opponents turn
  else if game.turn is 0
    if @moveTo > 0
      if @attrs.y < @moveTo

        # this.attrs.y += this.speed;
        @move y: @speed
      else

        # this.attrs.y -= this.speed;
        @move y: -@speed
      ball.setOnPlayerPosition this
      @moveTo -= @speed
    else

      # $('#ping')[0].play();
      ball.start()

Opponent::levelUp = ->
  @speed += 1

Opponent::lifeLost = ->
  @moveTo = parseInt(Math.random() * 400)