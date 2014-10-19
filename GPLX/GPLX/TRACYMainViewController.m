//
//  TRACYMainViewController.m
//  GPLX
//
//  Created by TRACY on 3/9/14.
//  Copyright (c) 2014 TRACY. All rights reserved.
//

#import "TRACYMainViewController.h"


//tracy: declare constant of size of button
const float k_fWidthBetweenButton = 20;
const float k_fWidthButton = 123.5;
const float k_fHeightBetweenButton = 20;;
const float k_fHeightButton = 146;
const float k_fWidthOffset = 25.25;
const float k_fHeightOffset = 60;

@interface TRACYMainViewController ()

@end

@implementation TRACYMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //-------
    //tracy: set background for main view
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage: [UIImage imageNamed: @"backgroundMainView.jpg"]];
    
    //tracy: set properties for button collection of questions
    [self.btnCollectionMainView setTitle:@"" forState:UIControlStateNormal];
    [self.btnCollectionMainView setFrame: CGRectMake(k_fWidthOffset, k_fHeightOffset, k_fWidthButton, k_fHeightButton)];
    [self.btnCollectionMainView setBackgroundImage:[UIImage imageNamed:@"btnCollectionMainView.png"] forState:UIControlStateNormal];
    
    //tracy: set properties for button exam
    [self.btnExamMainView setTitle:@"" forState:UIControlStateNormal];
    [self.btnExamMainView setFrame: CGRectMake(k_fWidthOffset + k_fWidthButton + k_fWidthBetweenButton, k_fHeightOffset, k_fWidthButton, k_fHeightButton)];
    [self.btnExamMainView setBackgroundImage:[UIImage imageNamed:@"btnExamMainView.png"] forState:UIControlStateNormal];
    
    //tracy: set properties for button trick
    [self.btnTrickMainView setTitle:@"" forState:UIControlStateNormal];
    [self.btnTrickMainView setFrame: CGRectMake(k_fWidthOffset , k_fHeightOffset + k_fHeightButton + k_fHeightBetweenButton, k_fWidthButton, k_fHeightButton)];
    [self.btnTrickMainView setBackgroundImage:[UIImage imageNamed:@"btnTrickMainView.png"] forState:UIControlStateNormal];
    
    //tracy: set properties for button road sign
    [self.btnSignMainView setTitle:@"" forState:UIControlStateNormal];
    [self.btnSignMainView setFrame: CGRectMake(k_fWidthOffset + k_fWidthButton + k_fWidthBetweenButton, k_fHeightOffset + k_fHeightButton + k_fHeightBetweenButton, k_fWidthButton, k_fHeightButton)];
    [self.btnSignMainView setBackgroundImage:[UIImage imageNamed:@"btnSignMainView.png"] forState:UIControlStateNormal];
    //----------
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
