/* opponent class */
function Opponent() {
    var config = {
        fill: 'white',
        x : 735,
        y : 300,
        width: 15,
        height: 60
    };
    Kinetic.Rect.call(this, config);
    this.speed = 4;
    this.moveTo = undefined;
    this.name = 'Opponent';
};
Opponent.prototype = new Kinetic.Rect({});
Opponent.prototype.constructor = Opponent;

Opponent.prototype.changePosition = function(game, ball) {
    var new_y = undefined;

    // moving ball
    if (ball.speed > 0) {
        if (ball.attrs.x >= 425) {
           new_y = ball.attrs.y;
        } else { new_y = 300 };

        if (this.attrs.y < new_y) {
            // this.attrs.y += this.speed;
            this.move({y: this.speed});
        } else if (this.attrs.y > new_y) {
            // this.attrs.y -= this.speed;
            this.move({y: -this.speed});
        }

    // opponents turn
    } else if (game.turn == 0) {
        if (this.moveTo > 0){
            if (this.attrs.y < this.moveTo) {
                // this.attrs.y += this.speed;
                this.move({y: this.speed});
            } else {
                // this.attrs.y -= this.speed;
                this.move({y: -this.speed});
            };
            ball.setOnPlayerPosition(this);
            this.moveTo -= this.speed;
        } else {
            // $('#ping')[0].play();
            ball.start();
        };
    };
};

Opponent.prototype.levelUp = function(){
    this.speed += 1;
};

Opponent.prototype.lifeLost = function(){
    this.moveTo = parseInt(Math.random()*400);
};
