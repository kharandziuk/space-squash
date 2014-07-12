/* game class */
function Game(stage, anim, foregroundLayer, player, opponent, ball) {
    this.stage = stage;
    this.anim = anim;
    this.foregroundLayer = foregroundLayer;
    this.level = 1;
    this.player = player;
    this.opponent = opponent;
    this.ball = ball;
    this.scoreMessages = new Array();
    this.running = false;
    this.turn = 1; // 1: player, 0: opponent
    this.over = false;
};

Game.prototype.stop = function() {
    this.running = false;
    this.anim.stop();
};

Game.prototype.start = function() {
    var this_ = this;
    this.running = true;
    console.log('anim start');
    this.anim.start();
};

Game.prototype.levelUp = function(){
    var fl = this.foregroundLayer;
    var message = new Kinetic.Text({
        x : 350,
        y : 300,
        fontSize : 15,
        fontFamily : 'Calibri',
        text : 'Level Up',
        textFill : 'white'
    });
    this.scoreMessages.push(message);
    this.foregroundLayer.add(message);
    this.ball.levelUp(this.player);
    this.player.levelUp(100*this.level, this);
    this.level += 1;
    this.turn = 1;
    this.opponent.levelUp();
    // this.resume(this.player.attrs.x + 15);
    this.resume(this.player.move({x: 15}));
};

Game.prototype.lifeLost = function(){
    if (this.player.lives > 0) {
        this.player.lifeLost();
        var message = new Kinetic.Text({
            x : 350,
            y : 300,
            fontSize : 15,
            fontFamily : 'Calibri',
            text : '-1 life',
            textFill : 'white'
        });
        this.scoreMessages.push(message);
        this.foregroundLayer.add(message);
    }
    this.opponent.lifeLost();
    this.ball.lifeLost(this.opponent);
    this.turn = 0;
    this.resume();
};

Game.prototype.resume = function() {

    if (this.player.lives > 0) {

    } else {

        this.stop();
        for (i in this.scoreMessages){
            this.foregroundLayer.remove(this.scoreMessages[i]);
        }

        var mbg = new Kinetic.Rect({
            x : 260,
            y : 250,
            width: 300,
            height: 120,
            fill : '#666',
            alpha : 0.9
        });

        var message = new Kinetic.Text({
            x : 350,
            y : 285,
            fontSize : 14,
            fontFamily : 'Calibri',
            text : 'GAME OVER',
            textFill : 'white'
        });

        var restart = new Kinetic.Text({
            x : 320,
            y : 310,
            fontSize : 13,
            fontFamily : 'Calibri',
            text : 'press <F5> to restart',
            textFill : 'white'
        });

        $('#score').val(this.player.points);

        $('#highscoreform').overlay({
            load : true,
            mask : {
                color : 'black'
            }
        });
        this.over = true;
        this.foregroundLayer.add(mbg);
        this.foregroundLayer.add(message);
        this.foregroundLayer.add(restart);
    }
};