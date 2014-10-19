//
//  TRACYMainViewController.h
//  GPLX
//
//  Created by TRACY on 3/9/14.
//  Copyright (c) 2014 TRACY. All rights reserved.
//

#import <UIKit/UIKit.h>


//tracy: declare constant of size of button
extern const float k_fWidthBetweenButton;
extern const float k_fWidthButton;
extern const float k_fHeightBetweenButton;
extern const float k_fHeightButton;
extern const float k_fWidthOffset;
extern const float k_fHeightOffset;

@interface TRACYMainViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *btnCollectionMainView;
@property (strong, nonatomic) IBOutlet UIButton *btnExamMainView;
@property (strong, nonatomic) IBOutlet UIButton *btnTrickMainView;
@property (strong, nonatomic) IBOutlet UIButton *btnSignMainView;

@end
