$(function(){
    initStage();
});

function initStage(){

    var stage = new Kinetic.Stage({
        container : "board",
        width: 800,
        height: 600
    });

    // background
    var backgroundLayer = new Kinetic.Layer();
    var background = new Kinetic.Rect({
        fill: 'black',
        x : 0,
        y : 0,
        width : 800,
        height : 600
    });

    var middleLine = new Kinetic.Group();
    for (var y = 0; y <= 700; y += 38.7) {
        var linePart = new Kinetic.Rect({
            x : 398,
            y : y,
            width : 4,
            height : 19.5,
            fill : 'white'
        });
        middleLine.add(linePart);
    };

    backgroundLayer.add(background);
    backgroundLayer.add(middleLine);

    // foreground
    var foregroundLayer = new Kinetic.Layer();

    // player
    var player = new Player();

    foregroundLayer.add(player);

    // computer
    var opponent = new Opponent();
    foregroundLayer.add(opponent);

    // ball
    var ball = new Ball();
    window.ball = ball;
    foregroundLayer.add(ball);

    var anim = new Kinetic.Animation(animOnframe, foregroundLayer);

    // game obj
    var game = new Game(stage, anim, foregroundLayer, player, opponent, ball);

    // scoreboard
    var textLives = new Kinetic.Text({
        x : 0,
        y : 0,
        text : 'Lives: '+player.lives,
        textFill : 'white',
        padding : 5,
        fontSize : 8
    });
    foregroundLayer.add(textLives);

    var textLevel = new Kinetic.Text({
        x : 50,
        y : 0,
        text : 'Level :'+ game.level,
        textFill: 'white',
        padding : 5,
        fontSize : 8
    });
    foregroundLayer.add(textLevel);

    var textScore = new Kinetic.Text({
        x: 100,
        y : 0,
        text : 'Score: '+player.points,
        textFill : 'white',
        padding : 5,
        fontSize : 8
    });
    foregroundLayer.add(textScore);

    var welcomeScreen = new Kinetic.Group();
    var wbg = new Kinetic.Rect({
                x : 260,
                y : 230,
                width: 290,
                height: 120,
                fill : '#666',
                alpha: 0.9
    });
    var controlsHead = new Kinetic.Text({
                x : 295,
                y : 245,
                fontSize : 12,
                fontFamily : 'Calibri',
                text : 'controls:',
                textFill : 'white'
    });            var controls = new Kinetic.Text({
                x : 295,
                y : 265,
                fontSize : 12,
                fontFamily : 'Calibri',
                text : 'use w,a,s,d or arrows to move',
                textFill : 'white'
    });
    var controlsBall = new Kinetic.Text({
                x : 295,
                y : 285,
                fontSize : 12,
                fontFamily : 'Calibri',
                text : 'SPACE starts the ball',
                textFill : 'white'
    });
    var start = new Kinetic.Text({
                x : 295,
                y : 315,
                fontSize : 13,
                fontFamily : 'Calibri',
                text : 'press SPACE to start game',
                textFill : 'white'
    });
    welcomeScreen.add(wbg);
    welcomeScreen.add(controlsHead);
    welcomeScreen.add(controls);
    welcomeScreen.add(controlsBall);
    welcomeScreen.add(start);
    // foregroundLayer.add(welcomeScreen);

    stage.add(backgroundLayer);
    stage.add(foregroundLayer);

    // key events
    var input = {};
    document.addEventListener('keydown', function(e){

        if (game.running == true) {
            e.preventDefault();
        };

        input[e.which] = true;

        // start game
        if (input[32] == true && game.over == false) {
            e.preventDefault();
            if (game.running == false) {
                // foregroundLayer.remove(welcomeScreen);
                game.start();
                game.ball.stop();
                game.ball.setOnPlayerPosition(game.player);
                game.ball.start();
            } else {
                if (game.turn == 1) {
                    game.ball.start();
                };
            };
        };

    });
    document.addEventListener('keyup', function(e){
        input[e.which] = false;
    });

    function animOnframe(){
        if (input[40] == true || input[83] == true) {
            player.moveDown();
        } else if (input[38] == true || input[87] == true ) {
            player.moveUp();
        } else if (input[37] == true || input[65] == true) {
            player.moveLeft();
        } else if (input[39] == true || input[68] == true) {
            player.moveRight();
        };

        opponent.changePosition(game, ball);
        ball.changePosition(game, player, opponent);

        for ( i in game.scoreMessages ) {
            // game.scoreMessages[i].attrs.y -= 5;
            game.scoreMessages[i].move({y: -5});

            // game.scoreMessages[i].setAlpha(game.scoreMessages[i].attrs.alpha - 0.01);
        };

        // refresh scoreboard
        textLives.attrs.text = 'Lives: '+player.lives;
        textLevel.attrs.text = 'Level: '+game.level;
        textScore.attrs.text = 'Score: '+player.points;
    };

};
