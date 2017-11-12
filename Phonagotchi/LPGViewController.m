//
//  LPGViewController.m
//  Phonagotchi
//
//  Created by Steven Masuch on 2014-07-26.
//  Copyright (c) 2014 Lighthouse Labs. All rights reserved.
//

#import "LPGViewController.h"

@interface LPGViewController ()

@property (nonatomic) UIImageView *petImageView;
@property (nonatomic) UIImageView *bucketImageView;
@property (nonatomic) UIImageView *appleImageView;


@end

@implementation LPGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.view.backgroundColor = [UIColor colorWithRed:(252.0/255.0) green:(240.0/255.0) blue:(228.0/255.0) alpha:1.0];
    
    self.petImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.petImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.petImageView];
    self.petImageView.userInteractionEnabled = YES;
    
    [NSLayoutConstraint constraintWithItem:self.petImageView
                                  attribute:NSLayoutAttributeCenterX
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self.view
                                  attribute:NSLayoutAttributeCenterX
                                 multiplier:1.0
                                   constant:0.0].active = YES;
    
    [NSLayoutConstraint constraintWithItem:self.petImageView
                                  attribute:NSLayoutAttributeCenterY
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self.view
                                  attribute:NSLayoutAttributeCenterY
                                 multiplier:1.0
                                   constant:0.0].active = YES;
    
    [self changePetImage:@"default.png"];

    
    self.bucketImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    self.bucketImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.bucketImageView];
    
    [NSLayoutConstraint constraintWithItem:self.bucketImageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:-25].active = YES;
    [NSLayoutConstraint constraintWithItem:self.bucketImageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:25].active = YES;
    [NSLayoutConstraint constraintWithItem:self.bucketImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:175].active = YES;
    [NSLayoutConstraint constraintWithItem:self.bucketImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1 constant:175].active = YES;
    
    self.bucketImageView.image = [UIImage imageNamed:@"bucket.png"];
    
    
    [self createApple];

    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(velocityWithGestureRecognizer:)];
    [self.petImageView addGestureRecognizer:panGestureRecognizer];
    
    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinchOnAppleView:)];
    [self.appleImageView addGestureRecognizer:pinchGestureRecognizer];

}

-(void)changePetImage:(NSString*)petImage{
    self.petImageView.image = [UIImage imageNamed:petImage];
}

-(void)createApple {
    
    self.appleImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    self.appleImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.appleImageView];
    self.appleImageView.userInteractionEnabled = YES;
    
    [NSLayoutConstraint constraintWithItem:self.appleImageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.bucketImageView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.appleImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.bucketImageView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.appleImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:70].active = YES;
    [NSLayoutConstraint constraintWithItem:self.appleImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1 constant:70].active = YES;
    
    self.appleImageView.image = [UIImage imageNamed:@"apple.png"];

    
}

-(void)velocityWithGestureRecognizer:(UIPanGestureRecognizer *)panGestureRecognizer {
    CGPoint velocity = [panGestureRecognizer velocityInView:self.view];
    NSLog(@"Horizontal Velocity: %.2f points/sec", velocity.x);
    NSLog(@"Vertical Velocity: %.2f points/sec", velocity.y);
    
    if (fabs(velocity.x) > 50 && abs(velocity.y > 50)) {
        [self changePetImage:@"grumpy.png"];
        [self performSelector:@selector(changePetImage:) withObject:@"default.png" afterDelay:1.0];

    }
}

-(void)pinchOnAppleView:(UIPinchGestureRecognizer*)sender {
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
        {[self createApple];}
            break;
        case UIGestureRecognizerStateChanged:
        {CGPoint locationInView = [sender locationInView:self.view];
            sender.view.center = locationInView;
        }
            break;
        case UIGestureRecognizerStateEnded:
        {if (CGRectIntersectsRect( self.petImageView.frame,self.appleImageView.frame)) {
            NSLog(@"You dropped it inside the cat!");
        } else {
            NSLog(@"You dropped it outside the cat!");
            //        [self.appleImageView removeFromSuperview];
        }
        }
            break;
        default:
            break;
    }
}




@end
