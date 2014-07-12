/* player class */
function Player() {
    var config = {
        fill: 'white',
        x : 50,
        y : 300,
        width: 15,
        height: 60
    };
    Kinetic.Rect.call(this, config);
    this.speed = 4;
    this.lives = 3;
    this.points = 0;
    this.name = 'Player';
};
Player.prototype = new Kinetic.Rect({});
Player.prototype.constructor = Player;

Player.prototype.moveDown = function(playerSpeed) {
    if (this.attrs.y < 570) {
        // this.attrs.y += this.speed;
        this.move({y: this.speed});
    };
};

Player.prototype.moveUp = function(playerSpeed) {
    if (this.attrs.y > -30)
    // this.attrs.y -= this.speed;
    this.move({y: -this.speed});
};

Player.prototype.moveLeft = function(playerSpeed) {
    if (this.attrs.x > 0) {
        // this.attrs.x -= this.speed;
        this.move({x: -this.speed});
    };
};

Player.prototype.moveRight = function(playerSpeed) {
    if (this.attrs.x < 385) {
        // this.attrs.x += this.speed;
        this.move({x: this.speed});
    };
};

Player.prototype.score = function(points, game){
    this.points += points;
    var scoreText = new Kinetic.Text({
        x : this.attrs.x,
        y : this.attrs.y+10,
        text : points,
        textFill : 'white',
        fontFamily : 'Calibri',
        fontSize : 15
    });
    game.scoreMessages.push(scoreText);
    game.foregroundLayer.add(scoreText);
};

Player.prototype.levelUp = function(points, game){
    this.speed += 1;
    this.score(points, game);
};

Player.prototype.lifeLost = function() {
    this.lives -= 1;
};
