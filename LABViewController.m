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

@interface LABViewController ()

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
    UIDynamicItemBehavior * blackHoleBehavior2;
    UIDynamicItemBehavior * blackHoleBehavior3;
    UIDynamicItemBehavior * blackHoleBehavior4;
    UIDynamicItemBehavior * blackHoleBehavior5;
    
    UIButton * startButton;
    NSMutableArray * walls;
    UIView * wall;
    UIView * wall2;
    UIView * wall3;
    UIView * wall4;
    UIView * wall5;
    
    UIView * blackHole;
    UIView * blackHole2;
    UIView * blackHole3;
    UIView * blackHole4;
    UIView * blackHole5;

    
    float xRotation;
    float yRotation;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
        
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    
    [super viewDidLoad];
    animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    gravityBehavior = [[UIGravityBehavior alloc] init];
    [animator addBehavior:gravityBehavior];
    
    collisionBehavior = [[UICollisionBehavior alloc] init];
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    [animator addBehavior:collisionBehavior];
    
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.width);
    //self.view.backgroundColor = [UIColor colorWithRed:0.835f green:0.812f blue:0.682f alpha:1.0f];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"wood"]];
    
    UIView * hole = [[UIView alloc] initWithFrame:CGRectMake(5, 10, 40, 40)];
    hole.backgroundColor = [UIColor greenColor];
    hole.layer.cornerRadius = 20;
    hole.layer.borderWidth = 2.0;
    hole.layer.borderColor = [[UIColor blackColor]CGColor];
    [self.view addSubview:hole];
    
    ballItemBehavior = [[UIDynamicItemBehavior alloc] init];
    ballItemBehavior.friction = 0;
    ballItemBehavior.elasticity = 0;
    ballItemBehavior.resistance = 0;
    ballItemBehavior.allowsRotation = NO;
    [animator addBehavior:ballItemBehavior];
    
    
    
    UIView * ball = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    ball.center = self.view.center;
    ball.layer.borderWidth = 2.0;
    ball.layer.borderColor = [[UIColor blackColor]CGColor];
    ball.backgroundColor = [UIColor redColor];
    
   
    ball.layer.cornerRadius = 20;
    [self.view addSubview:ball];
    
    [gravityBehavior addItem:ball];
    [collisionBehavior addItem:ball];
    [ballItemBehavior addItem:ball];
    
    wall = [[UIView alloc] initWithFrame:CGRectMake(50, 0, 50, 200)];
    //wall.backgroundColor = [UIColor colorWithRed:0.722f green:0.647f blue:0.510f alpha:1.0f];
    wall.layer.cornerRadius = 10;
    wall.layer.borderWidth = 2.0;
    wall.layer.borderColor = [[UIColor blackColor]CGColor];
    wall.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"leather"]];
    [self.view addSubview:wall];
    
    wall2 = [[UIView alloc] initWithFrame:CGRectMake(230, 0, 50, 200)];
    //wall2.backgroundColor = [UIColor colorWithRed:0.722f green:0.647f blue:0.510f alpha:1.0f];
    wall2.layer.cornerRadius = 10;
    wall2.layer.borderWidth = 2.0;
    wall2.layer.borderColor = [[UIColor blackColor]CGColor];
    wall2.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"leather"]];
    [self.view addSubview:wall2];
    
    //wall3 = [[UIView alloc] initWithFrame:CGRectMake(250, 0, 50, 200)];
    //wall3.backgroundColor = [UIColor colorWithRed:0.722f green:0.647f blue:0.510f alpha:1.0f];
    //wall3.layer.cornerRadius = 10;
    //wall3.layer.borderWidth = 2.0;
    //wall3.layer.borderColor = [[UIColor blackColor]CGColor];
    //wall3.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"leather"]];
    //[self.view addSubview:wall3];
    
    wall4 = [[UIView alloc] initWithFrame:CGRectMake(350, 150, 50, 200)];
    //wall4.backgroundColor = [UIColor colorWithRed:0.722f green:0.647f blue:0.510f alpha:1.0f];
    wall4.layer.cornerRadius = 10;
    wall4.layer.borderWidth = 2.0;
    wall4.layer.borderColor = [[UIColor blackColor]CGColor];
    wall4.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"leather"]];
    [self.view addSubview:wall4];
    
    //wall5 = [[UIView alloc] initWithFrame:CGRectMake(450, 0, 50, 200)];
    //wall5.backgroundColor = [UIColor colorWithRed:0.722f green:0.647f blue:0.510f alpha:1.0f];
    //wall5.layer.cornerRadius = 10;
    //wall5.layer.borderWidth = 2.0;
    //wall5.layer.borderColor = [[UIColor blackColor]CGColor];
    //wall5.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"leather"]];
    //[self.view addSubview:wall5];
    
    blackHole = [[UIView alloc] initWithFrame:CGRectMake(450, 0, 40, 40)];
    blackHole.backgroundColor = [UIColor blackColor];
    blackHole.layer.cornerRadius = 20;
    blackHole.layer.borderWidth = 2.0;
    blackHole.layer.borderColor = [[UIColor blackColor]CGColor];
    [self.view addSubview:blackHole];
    
    blackHole2 = [[UIView alloc] initWithFrame:CGRectMake(450, 50, 40, 40)];
    blackHole2.backgroundColor = [UIColor blackColor];
    blackHole2.layer.cornerRadius = 20;
    blackHole2.layer.borderWidth = 2.0;
    blackHole2.layer.borderColor = [[UIColor blackColor]CGColor];
    [self.view addSubview:blackHole2];
    
    blackHole3 = [[UIView alloc] initWithFrame:CGRectMake(450, 100, 40, 40)];
    blackHole3.backgroundColor = [UIColor blackColor];
    blackHole3.layer.cornerRadius = 20;
    blackHole3.layer.borderWidth = 2.0;
    blackHole3.layer.borderColor = [[UIColor blackColor]CGColor];
    [self.view addSubview:blackHole3];
    
    blackHole4 = [[UIView alloc] initWithFrame:CGRectMake(450, 150, 40, 40)];
    blackHole4.backgroundColor = [UIColor blackColor];
    blackHole4.layer.cornerRadius = 20;
    blackHole4.layer.borderWidth = 2.0;
    blackHole4.layer.borderColor = [[UIColor blackColor]CGColor];
    [self.view addSubview:blackHole4];
    
    blackHole5 = [[UIView alloc] initWithFrame:CGRectMake(450, 200, 40, 40)];
    blackHole5.backgroundColor = [UIColor blackColor];
    blackHole5.layer.cornerRadius = 20;
    blackHole5.layer.borderWidth = 2.0;
    blackHole5.layer.borderColor = [[UIColor blackColor]CGColor];
    [self.view addSubview:blackHole5];
    
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
    wall4Behavior.density = 10000000000;
    [animator addBehavior:wall4Behavior];
    
    //wall5Behavior = [[UIDynamicItemBehavior alloc] init];
    //wall5Behavior.density = 10000000000;
    //[animator addBehavior:wall5Behavior];

    blackHoleBehavior = [[UIDynamicItemBehavior alloc] init];
    blackHoleBehavior.density = 10000000000;
    [animator addBehavior:blackHoleBehavior];
    
    blackHoleBehavior2 = [[UIDynamicItemBehavior alloc] init];
    blackHoleBehavior2.density = 10000000000;
    [animator addBehavior:blackHoleBehavior2];
    
    blackHoleBehavior3 = [[UIDynamicItemBehavior alloc] init];
    blackHoleBehavior3.density = 10000000000;
    [animator addBehavior:blackHoleBehavior3];
    
    blackHoleBehavior4 = [[UIDynamicItemBehavior alloc] init];
    blackHoleBehavior4.density = 10000000000;
    [animator addBehavior:blackHoleBehavior4];
    
    blackHoleBehavior5 = [[UIDynamicItemBehavior alloc] init];
    blackHoleBehavior5.density = 10000000000;
    [animator addBehavior:blackHoleBehavior5];
    
    
    
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
    
    //[collisionBehavior addItem:blackHole];
    [blackHoleBehavior addItem:blackHole];
    
    //[collisionBehavior addItem:blackHole2];
    [blackHoleBehavior2 addItem:blackHole2];
    
    //[collisionBehavior addItem:blackHole3];
    [blackHoleBehavior3 addItem:blackHole3];
    
    //[collisionBehavior addItem:blackHole4];
    [blackHoleBehavior4 addItem:blackHole4];
    
    //[collisionBehavior addItem:blackHole5];
    [blackHoleBehavior5 addItem:blackHole5];
    
    //[collisionBehavior addItem:wall5];
    //[wallBehavior addItem:wall5];
    
   // [self showStartButton];
//    startButton = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH -100) /2.0,(SCREEN_HEIGHT -100) /2.0, 100, 100)];
//    [startButton setTitle: @"START" forState:UIControlStateNormal];
//    [startButton addTarget:self action:@selector(startGame) forControlEvents:UIControlEventTouchUpInside];
//    startButton.backgroundColor = [UIColor grayColor];
//    startButton.layer.cornerRadius = 50;
//    [self.view addSubview:startButton];
    
    // Do any additional setup after loading the view.
//    LABGraphView * graphView = [[LABGraphView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.width)];
//    
//    CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.width);
//    
    motionManager = [[CMMotionManager alloc] init];
    [motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMDeviceMotion *motion, NSError *error) {
        NSLog(@"x %f y %f z %f", motion.rotationRate.x,motion.rotationRate.y,motion.rotationRate.z);
        
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

/// messing with start button
//-(void)showStartButton
//{
//    for (wall in walls)
//    {
//        [wall removeFromSuperview];
//        [wallBehavior removeItem:wall];
//        [collisionBehavior removeItem:wall];
//    }
//    [walls removeAllObjects];
//    
//    startButton = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH -100) /2.0,(SCREEN_HEIGHT -100) /2.0, 100, 100)];
//    [startButton setTitle: @"START" forState:UIControlStateNormal];
//    [startButton addTarget:self action:@selector(startGame) forControlEvents:UIControlEventTouchUpInside];
//    startButton.backgroundColor = [UIColor grayColor];
//    startButton.layer.cornerRadius = 50;
//    [self.view addSubview:startButton];
//    
//}
//-(void)startGame
//{
//    [startButton removeFromSuperview];
//    //headerView.lives = 3;
//    //headerView.score = 0;
//}
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(BOOL) prefersStatusBarHidden {return YES;}

@end
