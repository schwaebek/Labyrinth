//
//  LABViewController.m
//  Labyrinth
//
//  Created by Katlyn Schwaebe on 8/14/14.
//  Copyright (c) 2014 Katlyn Schwaebe. All rights reserved.
//

#import "LABViewController.h"
#import <CoreMotion/CoreMotion.h>
#import "LABGraphView.h"

@interface LABViewController () <UICollisionBehaviorDelegate>

@end

@implementation LABViewController
{
    CMMotionManager * motionManager;
    
    UIDynamicAnimator * animator;
    UIGravityBehavior * gravityBehavior;
    UICollisionBehavior * collisionBehavior;
    UIDynamicItemBehavior * wallBehavior;
    UIDynamicItemBehavior * wall2Behavior;
    UIDynamicItemBehavior * wall3Behavior;
    UIDynamicItemBehavior * wall4Behavior;
    UIDynamicItemBehavior * wall5Behavior;
    UIDynamicItemBehavior * ballItemBehavior;
    UIDynamicItemBehavior * blackHoleBehavior;
 
    UIButton * startButton;
    UIView * ball;
    
    NSMutableArray* blackHoles;
    NSMutableArray * walls;
    
    
    UIView * hole;
    NSTimer *timer;
    UILabel * timeClock;
    
    int remainingCounts;
    
    float xRotation;
    float yRotation;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        blackHoles = [@[] mutableCopy];
        walls = [@[] mutableCopy];
        
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
   
    
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.width);
    //self.view.backgroundColor = [UIColor colorWithRed:0.835f green:0.812f blue:0.682f alpha:1.0f];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"wood"]];
    
    [self showStartButton];
}

-(void)prepareGameElements
{
    animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    gravityBehavior = [[UIGravityBehavior alloc] init];
    [animator addBehavior:gravityBehavior];
    
    collisionBehavior = [[UICollisionBehavior alloc] init];
    collisionBehavior.collisionDelegate = self;
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    [animator addBehavior:collisionBehavior];
    
    //int remainingCounts;
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1
                                             target:self
                                           selector:@selector(countDown)
                                           userInfo:nil
                                            repeats:YES];
    //remainingCounts = 60;
    
    
    hole = [[UIView alloc] initWithFrame:CGRectMake(5, 10, 40, 40)];
    hole.backgroundColor = [UIColor greenColor];
    hole.layer.cornerRadius = 20;
    hole.layer.borderWidth = 2.0;
    hole.layer.borderColor = [[UIColor blackColor]CGColor];
    [self.view addSubview:hole];
    
    timeClock= [[UILabel alloc] initWithFrame:CGRectMake(480, 10, 80, 40)];
    timeClock.backgroundColor = [UIColor whiteColor];
    timeClock.textColor = [UIColor blackColor];
    timeClock.layer.borderWidth = 2.0;
    timeClock.layer.borderColor = [[UIColor blackColor]CGColor];
    [self.view addSubview:timeClock];
    
    
    
    ballItemBehavior = [[UIDynamicItemBehavior alloc] init];
//    ballItemBehavior.friction = 0;
//    ballItemBehavior.elasticity = 0;
//    ballItemBehavior.resistance = 0;
    //ballItemBehavior.density = 100000;
    ballItemBehavior.allowsRotation = NO;
    [animator addBehavior:ballItemBehavior];
    
    ball = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    //ball.center = self.view.center;
    ball.center = CGPointMake(525, 300);
    ball.layer.borderWidth = 2.0;
    ball.layer.borderColor = [[UIColor blackColor]CGColor];
    ball.backgroundColor = [UIColor redColor];
    ball.layer.cornerRadius = 20;
    [self.view addSubview:ball];
    
    [gravityBehavior addItem:ball];
    [collisionBehavior addItem:ball];
    [ballItemBehavior addItem:ball];
    
    UIView * wall = [[UIView alloc] initWithFrame:CGRectMake(50, 0, 50, 200)];
    //wall.backgroundColor = [UIColor colorWithRed:0.722f green:0.647f blue:0.510f alpha:1.0f];
    wall.layer.cornerRadius = 10;
    wall.layer.borderWidth = 2.0;
    wall.layer.borderColor = [[UIColor blackColor]CGColor];
    wall.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"metal"]];
    [self.view addSubview:wall];
    [walls addObject:wall];
    
    UIView * wall2 = [[UIView alloc] initWithFrame:CGRectMake(230, 150, 50, 200)];
    //wall2.backgroundColor = [UIColor colorWithRed:0.722f green:0.647f blue:0.510f alpha:1.0f];
    wall2.layer.cornerRadius = 10;
    wall2.layer.borderWidth = 2.0;
    wall2.layer.borderColor = [[UIColor blackColor]CGColor];
    wall2.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"metal"]];
    [self.view addSubview:wall2];
    [walls addObject:wall2];
    
    //wall3 = [[UIView alloc] initWithFrame:CGRectMake(250, 0, 50, 200)];
    //wall3.backgroundColor = [UIColor colorWithRed:0.722f green:0.647f blue:0.510f alpha:1.0f];
    //wall3.layer.cornerRadius = 10;
    //wall3.layer.borderWidth = 2.0;
    //wall3.layer.borderColor = [[UIColor blackColor]CGColor];
    //wall3.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"leather"]];
    //[self.view addSubview:wall3];
    //[walls addObject:wall3];
    
    UIView * wall4 = [[UIView alloc] initWithFrame:CGRectMake(350, 0, 50, 200)];
    //wall4.backgroundColor = [UIColor colorWithRed:0.722f green:0.647f blue:0.510f alpha:1.0f];
    wall4.layer.cornerRadius = 10;
    wall4.layer.borderWidth = 2.0;
    wall4.layer.borderColor = [[UIColor blackColor]CGColor];
    wall4.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"metal"]];
    [self.view addSubview:wall4];
    [walls addObject:wall4];
    
    //wall5 = [[UIView alloc] initWithFrame:CGRectMake(450, 0, 50, 200)];
    //wall5.backgroundColor = [UIColor colorWithRed:0.722f green:0.647f blue:0.510f alpha:1.0f];
    //wall5.layer.cornerRadius = 10;
    //wall5.layer.borderWidth = 2.0;
    //wall5.layer.borderColor = [[UIColor blackColor]CGColor];
    //wall5.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"leather"]];
    //[self.view addSubview:wall5];
    //[walls addObject:wall5];
    
    wallBehavior = [[UIDynamicItemBehavior alloc] init];
    wallBehavior.density = 10000000000;
    [animator addBehavior:wallBehavior];
    
    wall2Behavior = [[UIDynamicItemBehavior alloc] init];
    wall2Behavior.density = 10000000000;
    [animator addBehavior:wall2Behavior];
    
    //wall3Behavior = [[UIDynamicItemBehavior alloc] init];
    //wall3Behavior.density = 10000000000;
    //[animator addBehavior:wall3Behavior];
    
    wall4Behavior = [[UIDynamicItemBehavior alloc] init];
    wall4Behavior.density = 10000000000000;
    [animator addBehavior:wall4Behavior];
    
    //wall5Behavior = [[UIDynamicItemBehavior alloc] init];
    //wall5Behavior.density = 10000000000;
    //[animator addBehavior:wall5Behavior];

    blackHoleBehavior = [[UIDynamicItemBehavior alloc] init];
    blackHoleBehavior.density = 10000000000;
    [animator addBehavior:blackHoleBehavior];
    
    [self createBlackHoles];

    [collisionBehavior addItem:wall];
    [wallBehavior addItem:wall];
    
    [collisionBehavior addItem:wall2];
    [wallBehavior addItem:wall2];
    
    //[collisionBehavior addItem:wall3];
    //[wallBehavior addItem:wall3];
    
    [collisionBehavior addItem:wall4];
    [wallBehavior addItem:wall4];
    
    //[collisionBehavior addItem:wall5];
    //[blackHoleBehavior addItem:wall5];
    
    //[collisionBehavior addItem:wall5];
    //[wallBehavior addItem:wall5];
    
    // Do any additional setup after loading the view.
//    LABGraphView * graphView = [[LABGraphView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.width)];
//    
//    CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.width);
//    
    motionManager = [[CMMotionManager alloc] init];
    [motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMDeviceMotion *motion, NSError *error) {
        //NSLog(@"x %f y %f z %f", motion.rotationRate.x,motion.rotationRate.y,motion.rotationRate.z);
        
        xRotation -= motion.rotationRate.x / 50;
        yRotation += motion.rotationRate.y / 50;
        [self updateGravity];
//        if (graphView.xPlots.count > self.view.frame.size.height /10.0)
//        {
//            [graphView.xPlots removeObjectAtIndex:0];
//        }
//        [graphView.xPlots addObject:@(motion.rotationRate.x * 200)];
//        [graphView setNeedsDisplay];
    }];
}


-(void)showStartButton
{
    for (UIView * wall in walls)
    {
        [wall removeFromSuperview];
        [wallBehavior removeItem:wall];
        [collisionBehavior removeItem:wall];
    }
    [walls removeAllObjects];
    
    for (UIView * blackHole in blackHoles)
    {
        [blackHole removeFromSuperview];
        [blackHoleBehavior removeItem:blackHole];
        [collisionBehavior removeItem:blackHole];
        
    }
    
   
    [ballItemBehavior removeItem:ball];
    [collisionBehavior removeItem:ball];
    [gravityBehavior removeItem:ball];
    
    [ball removeFromSuperview];
        
        
        
    [blackHoles removeAllObjects];
    [hole removeFromSuperview];
    
    //[ballItemBehavior removeItem:ball];
    //[collisionBehavior removeItem:ball];
    //[gravityBehavior removeItem:ball];
    
    [ball removeFromSuperview];
    //[timeClock removeFromSuperview];
    
    
    startButton = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH -100) /2.0,(SCREEN_HEIGHT -100) /2.0, 100, 100)];
    [startButton setTitle: @"START" forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(startGame) forControlEvents:UIControlEventTouchUpInside];
    startButton.backgroundColor = [UIColor blackColor];
    startButton.layer.cornerRadius = 50;
    [self.view addSubview:startButton];
}

-(void)startGame
{
    [startButton removeFromSuperview];
    [self prepareGameElements];
}

-(void)updateGravity
{
    gravityBehavior.gravityDirection = CGVectorMake(xRotation, yRotation);
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    xRotation = yRotation = 0;
    [self updateGravity];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL) prefersStatusBarHidden {return YES;}

-(void)createBlackHoles
{
    UIView* blackHole = [[UIView alloc] initWithFrame:CGRectMake(450, 80, 40, 40)];
    blackHole.backgroundColor = [UIColor blackColor];
    blackHole.layer.cornerRadius = 20;
    blackHole.layer.borderWidth = 2.0;
    blackHole.layer.borderColor = [[UIColor blackColor]CGColor];
    [self.view addSubview:blackHole];
    
    UIView* blackHole2 = [[UIView alloc] initWithFrame:CGRectMake(450, 130, 40, 40)];
    blackHole2.backgroundColor = [UIColor blackColor];
    blackHole2.layer.cornerRadius = 20;
    blackHole2.layer.borderWidth = 2.0;
    blackHole2.layer.borderColor = [[UIColor blackColor]CGColor];
    [self.view addSubview:blackHole2];
    
    UIView* blackHole3 = [[UIView alloc] initWithFrame:CGRectMake(450, 180, 40, 40)];
    blackHole3.backgroundColor = [UIColor blackColor];
    blackHole3.layer.cornerRadius = 20;
    blackHole3.layer.borderWidth = 2.0;
    blackHole3.layer.borderColor = [[UIColor blackColor]CGColor];
    [self.view addSubview:blackHole3];
    
    UIView* blackHole4 = [[UIView alloc] initWithFrame:CGRectMake(450, 230, 40, 40)];
    blackHole4.backgroundColor = [UIColor blackColor];
    blackHole4.layer.cornerRadius = 20;
    blackHole4.layer.borderWidth = 2.0;
    blackHole4.layer.borderColor = [[UIColor blackColor]CGColor];
    [self.view addSubview:blackHole4];
    
    UIView* blackHole5 = [[UIView alloc] initWithFrame:CGRectMake(450, 280, 40, 40)];
    blackHole5.backgroundColor = [UIColor blackColor];
    blackHole5.layer.cornerRadius = 20;
    blackHole5.layer.borderWidth = 2.0;
    blackHole5.layer.borderColor = [[UIColor blackColor]CGColor];
    [self.view addSubview:blackHole5];
    
    UIView* blackHole6 = [[UIView alloc] initWithFrame:CGRectMake(100, 210, 40, 40)];
    blackHole6.backgroundColor = [UIColor blackColor];
    blackHole6.layer.cornerRadius = 20;
    blackHole6.layer.borderWidth = 2.0;
    blackHole6.layer.borderColor = [[UIColor blackColor]CGColor];
    [self.view addSubview:blackHole6];
    
    UIView* blackHole7 = [[UIView alloc] initWithFrame:CGRectMake(150, 210, 40, 40)];
    blackHole7.backgroundColor = [UIColor blackColor];
    blackHole7.layer.cornerRadius = 20;
    blackHole7.layer.borderWidth = 2.0;
    blackHole7.layer.borderColor = [[UIColor blackColor]CGColor];
    [self.view addSubview:blackHole7];
    
    UIView* blackHole8 = [[UIView alloc] initWithFrame:CGRectMake(50, 210, 40, 40)];
    blackHole8.backgroundColor = [UIColor blackColor];
    blackHole8.layer.cornerRadius = 20;
    blackHole8.layer.borderWidth = 2.0;
    blackHole8.layer.borderColor = [[UIColor blackColor]CGColor];
    [self.view addSubview:blackHole8];
    
    [blackHoles addObject:blackHole];
    [blackHoles addObject:blackHole2];
    [blackHoles addObject:blackHole3];
    [blackHoles addObject:blackHole4];
    [blackHoles addObject:blackHole5];
    [blackHoles addObject:blackHole6];
    [blackHoles addObject:blackHole7];
    [blackHoles addObject:blackHole8];
    
    [collisionBehavior addItem:blackHole];
    [blackHoleBehavior addItem:blackHole];
    
    [collisionBehavior addItem:blackHole2];
    [blackHoleBehavior addItem:blackHole2];
    
    [collisionBehavior addItem:blackHole3];
    [blackHoleBehavior addItem:blackHole3];
    
    [collisionBehavior addItem:blackHole4];
    [blackHoleBehavior addItem:blackHole4];
    
    [collisionBehavior addItem:blackHole5];
    [blackHoleBehavior addItem:blackHole5];
    
    [collisionBehavior addItem:blackHole6];
    [blackHoleBehavior addItem:blackHole6];
    
    [collisionBehavior addItem:blackHole7];
    [blackHoleBehavior addItem:blackHole7];
    
    [collisionBehavior addItem:blackHole8];
    [blackHoleBehavior addItem:blackHole8];
}
-(void)countDown
{
    timeClock.text = [NSString stringWithFormat:@"%d",[timeClock.text intValue] + 1];
    if (++remainingCounts > 5)
    {
        [timer invalidate];
        [self startGame];
        
        
        
        
    }
    
    
    
}

-(void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item1 withItem:(id<UIDynamicItem>)item2 atPoint:(CGPoint)p
{
    NSLog(@"collision");
    for (UIView * blackHole in [blackHoles copy])
    {
        if ([item1 isEqual:blackHole] || [item2 isEqual:blackHole])
        {
            [ball removeFromSuperview];
            [collisionBehavior removeItem:ball];
            [gravityBehavior removeItem:ball];
            [ballItemBehavior removeItem:ball];
            [self showStartButton];
        }
        
    }

}
@end
