
#Squirrel Chase written in Javascript
*Javascript, Canvas, Ruby, Rails, JQuery, HTML, CSS*

In Squirrel Chase you play as a dog with an insatiable appetite for acorns, but avoid the angry squirrels who are not happy that you are stealing their hard earned nuts.

Pick up acorns to score points and bones to get access to the squirrel stunning bark ability!

[Click here to play](http://www.squirrelchase.space)

##Features
- Keeps track of current score.
- Rails server saves scores and returns highscores.
- Squirrels track down and chase after it.
- Power ups
- Sprite based graphics


##Controls:
- Up: Accelerate forwards
- Down: Accelerate backwards
- Left: Turn left
- Right: Turn right
- Space: bark
- Enter: restart game



##Implementation details

###All objects extend either movingObject or stationaryObject
Inheritance is set up using an inherits utility function:
```Javascript
inherits: function (ChildClass, ParentClass) {
  function Surrogate() {}
  Surrogate.prototype = ParentClass.prototype;
  ChildClass.prototype = new Surrogate;
  ChildClass.prototype.constructor = ChildClass;
},
```

###Squirrels track the dog
Squirrels will always face the direction of the dog:

```Javascript
Squirrel.prototype.chase = function(pos) {
    var deltaY = pos[1] - this.pos[1];
    var deltaX = pos[0] - this.pos[0];
    var angleInRadians = Math.atan2(deltaY, deltaX);
    this.turn(angleInRadians);
};
```

###The dog accelerates in the direction it is facing
Impulse is provided by the up key, which then adds to the dogs current velocity:

```Javascript
Dog.prototype.power = function (impulse) {
  var xVel = impulse * Math.cos(this.direct) + this.vel[0];
  var yVel = impulse * Math.sin(this.direct) + this.vel[1];

  this.vel = [
   xVel > this.MAX_VELOCITY ? this.MAX_VELOCITY : xVel,
   yVel > this.MAX_VELOCITY ? this.MAX_VELOCITY : yVel
 ];
};
```

###The dog and squirrels use sprites to animate their movement
Using a sprite sheet, the dog and squirrels are animated when moving:
```Javascript
var tickCount = 0;
var frameIndex = 0;
var numberOfFrames = 3;

function sprite (options) {
    var that = {};
    that.context = options.context;
    that.width = options.width;
    that.height = options.height;
    that.image = options.image;
    that.ticksPerFrame = 4;

    that.render = function () {
        that.context.drawImage(
           that.image,
           frameIndex * that.width / 3,
           0,
           that.width / 3,
           that.height,
           -RADIUS,
           -RADIUS,
           RADIUS * 2,
           RADIUS * 2
         );
    };

    that.update = function () {
      if (tickCount > that.ticksPerFrame) {
        tickCount = 0;
        if (frameIndex < numberOfFrames - 1) {
          frameIndex += 1;
          } else {
          frameIndex = 0;
          }
        }
    };
    return that;
}
```

###A Rails backend stores scores and passes back the top scores
The server will return the top five scores

```Ruby
def self.top_five
  HighScore.all.order(score: :desc).limit(5)
end
```


##Gameplay photos

###Early Game
![Early Game](/readme_photos/early-game.png)

###Lots of Squirrels
![Lots of Squirrels](/readme_photos/many-squirrels.png)

###Dog stunned Squirrels
![Stunned Squirrels](/readme_photos/squirrels-stunned.png)

###Game over
![Game Over](/readme_photos/game-over.png)
