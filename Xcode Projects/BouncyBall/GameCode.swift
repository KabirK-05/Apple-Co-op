import Foundation

/*
The setup() function is called once when the app launches. Without it, your app won't compile.
Use it to set up and start your app.

You can create as many other functions as you want, and declare variables and constants,
at the top level of the file (outside any function). You can't write any other kind of code,
for example if statements and for loops, at the top level; they have to be written inside
of a function.
*/

let ball = OvalShape(width: 40, height: 40)
var barriers: [Shape] = []
var targets: [Shape] = []


// define funnel
let funnelPoints = [
    Point(x: 0, y: 50),
    Point(x: 80, y: 50),
    Point(x: 60, y: 0),
    Point(x: 20, y: 0)
]

let funnel = PolygonShape(points: funnelPoints)


// Handles collisions between the ball and the targets.
func ballCollided(with otherShape: Shape) {
    if otherShape.name != "target" {return}
    
    otherShape.fillColor = .green
}

func alertDismissed(){
}

func ballExitedScene(){
    for barrier in barriers {
        barrier.isDraggable = true
    
    }
    
    var hitTargets = 0
    for target in targets {
        if target.fillColor == .green {
            hitTargets += 1
        }
    }
    
    if hitTargets == targets.count {
        scene.presentAlert(text: "You won!", completion: alertDismissed)

    }
    
}

// Resets the game by moving the ball below the scene
// which will unlock the barriers.
func resetGame() {
    ball.position = Point(x: 0, y: -80)
}

func printPosition(of shape: Shape) {
    print(shape.position)
}


// define target
func addTarget(at position: Point) {
    
    let targetPoints = [
        Point(x: 10, y: 0),
        Point(x: 0, y: 10),
        Point(x: 10, y: 20),
        Point(x: 20, y: 10)
    ]
    let target = PolygonShape(points: targetPoints)
    targets.append(target)

    target.position = position
    target.hasPhysics = true
    target.isImmobile = true
    target.isImpermeable = false
    target.fillColor = .yellow
    target.isDraggable = false
    
    target.name = "target"
    scene.add(target)
}

// refactored setup code

fileprivate func ballSetup() {
    // add ball to scene
    ball.position = Point(x: 250, y: 400)
    ball.hasPhysics = true
    ball.fillColor = .blue
    ball.bounciness = 0.6
    scene.add(ball)
    
    ball.onTapped = resetGame
    scene.trackShape(ball)
    ball.onExitedScene = ballExitedScene
    
}

fileprivate func addBarrier(at position: Point, width: Double, height: Double, angle: Double) {
    // add barrier to scene
    let barrierPoints = [
            Point(x: 0, y: 0),
            Point(x: 0, y: height),
            Point(x: width, y: height),
            Point(x: width, y: 0)
        ]
    let barrier = PolygonShape(points: barrierPoints)
    barriers.append(barrier)

    barrier.hasPhysics = true
    barrier.isImmobile = true
    barrier.fillColor = .darkGray
    barrier.angle = angle
    barrier.position = position
    scene.add(barrier)
}

fileprivate func funnelSetup() {
    // add funnel to scene
    funnel.position = Point(x: 200, y: scene.height - 25)
    scene.add(funnel)
    funnel.fillColor = .lightGray
    funnel.isDraggable = false
    
    // drop ball when tapped
    funnel.onTapped = dropBall
}


fileprivate func addMultipleBarriersTargets() {
    // add target
    //addTarget(at: Point(x: 150, y: 400))
    
    // add multiple barriers
    addBarrier(at: Point(x: 200, y: 150), width: 80, height: 25, angle: 0.1)
    addBarrier(at: Point(x: 100, y: 150), width: 30, height: 15, angle: -0.2)
    addBarrier(at: Point(x: 300, y: 150), width: 100, height: 25, angle: 0.03)
    
    addTarget(at: Point(x: 133, y: 614))
    addTarget(at: Point(x: 111, y: 474))
    addTarget(at: Point(x: 256, y: 280))
    addTarget(at: Point(x: 151, y: 242))
    addTarget(at: Point(x: 165, y: 40))
}

func setup() {
    ballSetup()
    
    //addBarrier(at: Point(x: 200, y: 150), width: 80, height: 25, angle: 0.1)
    
    funnelSetup()
    
    addMultipleBarriersTargets()
    
    
    // get position of target
    scene.onShapeMoved = printPosition(of:)
    
    ball.onCollision = ballCollided(with:)
    resetGame()
}

// drops ball by moving it to the funnel's position
func dropBall() {
    ball.position = funnel.position
    ball.stopAllMotion()
    
    for barrier in barriers {
        barrier.isDraggable = false
    }
    for target in targets {
        target.fillColor = .yellow
    }
    
}


