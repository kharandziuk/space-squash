/* ball class */
function Ball() {
    var config = {
        radius : 10,
        fill : 'white',
        x : 75,
        y : 330

    };
    Kinetic.Circle.call(this, config);
    this.speed = 4;
    this.regularSpeed = 4;
    this.direction = { x: -1, y: -1 };

};
Ball.prototype = new Kinetic.Circle({});
Ball.prototype.constructor = Ball;

Ball.prototype.changePosition = function(game, player, opponent){
    if (this.attrs.x <= 0) {
        game.lifeLost();
    }

    else if (this.attrs.x >= 800 ) {
        game.levelUp();
    }

    else if (this.speed > 0 && this.attrs.y <= 0 || this.speed > 0 && this.attrs.y >= 600) {
        this.direction.y = this.direction.y * (-1)
    }

    else if (this.speed > 0 && player.intersects(this.getPosition()) ||
             this.speed > 0 && opponent.intersects(this.getPosition())) {

        // $('#ping')[0].play();
        this.direction.x = this.direction.x * (-1);

        if (player.intersects(this.getPosition())) {
            player.score(10*game.level, game);
            // this.attrs.x += 15;
            this.move({x: 15});

        } else {
            // this.attrs.x -= 15;
            this.move({x: -15});

        };

    } else if (this.speed == 0 && game.turn == 1){
        this.setOnPlayerPosition(player);
    };
    // this.attrs.x += this.speed * this.direction.x;
    this.move({x: this.speed * this.direction.x});
    // this.attrs.y += this.speed * this.direction.y;
    this.move({y: this.speed * this.direction.y});
};

Ball.prototype.start = function(){
    this.speed = this.regularSpeed;
};

Ball.prototype.stop = function(){
    this.speed = 0;
};

Ball.prototype.setOnPlayerPosition = function(side) {
    if (side.name == 'Player') {
        var x = 25;
    } else {
        var x = -10;
    };
    var x = side.getPosition().x + x;
    var y = side.getPosition().y + 30;
    this.setPosition({x : x, y : y});
};

Ball.prototype.levelUp = function(player) {
    this.speed += 1;
    this.regularSpeed += 1;
    this.stop();
    this.setOnPlayerPosition(player);
};

Ball.prototype.lifeLost = function(opponent) {
    this.stop();
    this.setOnPlayerPosition(opponent);
};
