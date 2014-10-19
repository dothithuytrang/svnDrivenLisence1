//
//  UITRACYQuestionBoard.m
//  testCustomControlQuestionBoard
//
//  Created by TRACY on 9/21/14.
//  Copyright (c) 2014 TRACY. All rights reserved.
//

#import "UITRACYQuestionBoard.h"

@implementation UITRACYQuestionBoard
@synthesize  uintOffsetY, uintNumRow, uintNumCol, uintCurrentTouchIndex, bButtonTouched;

//tracy: overide
- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    return self;
    
}

//tracy: init control, size of elements is streched based on size of control
- (void) initStretched: (NSUInteger) a_uintOffsetY : (NSUInteger) a_uintNumRow : (NSUInteger) a_uintNumCol : (float) a_fPaddingRatio : (float) a_fDistanceButtonRatio{
    
    uintOffsetY = a_uintOffsetY;
    uintNumRow = a_uintNumRow;
    uintNumCol = a_uintNumCol;
    
    //count size of background based on number of columns, rows and their sizes
    uintBackgroundWidth = self.frame.size.width;
    uintBackgroundHeight = self.frame.size.height;
    
    uintButtonWidth = uintBackgroundWidth / (uintNumCol*(1+a_fDistanceButtonRatio) + 2 * a_fPaddingRatio - a_fDistanceButtonRatio);
    uintDistanceButtonWidth = uintButtonWidth * a_fDistanceButtonRatio;
    uintPaddingWidth = uintButtonWidth * a_fPaddingRatio;
    
    uintButtonHeight = uintBackgroundHeight / (uintNumRow*(1+a_fDistanceButtonRatio) + 2 * a_fPaddingRatio - a_fDistanceButtonRatio);
    uintDistanceButtonHeight = uintButtonHeight * a_fDistanceButtonRatio;
    uintPaddingHeight = uintButtonHeight * a_fPaddingRatio;
    [self initImages];
}


//tracy: init images
- (void) initImages{//todo
    nsMutArImageView = [[NSMutableArray alloc] init];
    for(int i = 0; i < uintNumRow ; i++)
    {
        for(int j = 0; j < uintNumCol ; j++)
        {
            /* if use many image background
            NSString* nsStrButton = @"button";
            NSString* nsStrButtonIndex = [NSString stringWithFormat:@"%d", i * uintNumCol + j];
            NSString* nsStrExtention = @".jpeg";
            NSString* nsStrHighlightedExtention = @"Highlighted.jpeg";
            NSString* nsStrButtonImageName = [NSString stringWithFormat:@"%@%@%@", nsStrButton, nsStrButtonIndex, nsStrExtention];
            NSString* nsStrButtonHightlightedImageName = [NSString stringWithFormat:@"%@%@%@", nsStrButton, nsStrButtonIndex, nsStrHighlightedExtention];
            UIImageView* imgViewButton = [[UIImageView alloc] initWithImage:[UIImage imageNamed:nsStrButtonImageName]];*/
            //use 1 image background
            /*
             UIImageView* imgViewButton = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"btnSelectQuestionBoardCollection.png"]];
            
            [imgViewButton setHighlightedImage:[UIImage imageNamed:@"btnSelectQuestionBoardCollectionHighlighted.png"]];
            //[imgViewButton setUserInteractionEnabled:YES];*/
           UIButton* btn = [[UIButton alloc] init];
            [btn setBackgroundImage:[UIImage imageNamed:@"btnSelectQuestionBoardCollection.png"] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"btnSelectQuestionBoardCollectionHighlighted.png"] forState:UIControlStateHighlighted];
            [btn setTitle: [[NSString alloc] initWithFormat:@"%d", i * uintNumCol + j + 1 ] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            [btn setUserInteractionEnabled:false];
            
            [nsMutArImageView addObject:btn];
        }
    }
}


//tracy: render images onto control
-(void) render{
    //render background offset and background
    /* if use background image
    imgViewBackgroundOffset = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backgroundOffset.jpg"]];
    imgViewBackgroundBoard = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backgroundBoard.jpg"]];
    imgViewBackgroundOffset.frame = CGRectMake(0,0,uintBackgroundWidth,uintOffsetY);
    imgViewBackgroundBoard.frame = CGRectMake(0,uintOffsetY,uintBackgroundWidth,uintBackgroundHeight);
    
    [self addSubview:imgViewBackgroundOffset];
    [self addSubview:imgViewBackgroundBoard];
     */
    //in this case we use color

    [self setBackgroundColor: [UIColor colorWithRed:255/255.0 green:255/255.0 blue:112/255.0 alpha:1]];
    self.layer.borderColor = [UIColor blackColor].CGColor;
    self.layer.borderWidth = 1;
    
    //render buttons
    for(int i = 0; i < uintNumRow ; i++)
    {
        for(int j = 0; j < uintNumCol ; j++)
        {
            /*UIImageView* imgViewButton = [nsMutArImageView objectAtIndex : i * uintNumCol + j];
            imgViewButton.frame = CGRectMake(uintPaddingWidth + (uintDistanceButtonWidth + uintButtonWidth) * j, uintPaddingHeight + (uintDistanceButtonHeight + uintButtonHeight) * (i) + uintOffsetY,uintButtonWidth,uintButtonHeight);
             */
        UIButton* btn = [nsMutArImageView objectAtIndex : i * uintNumCol + j];
            btn.frame = CGRectMake(uintPaddingWidth + (uintDistanceButtonWidth + uintButtonWidth) * j, uintPaddingHeight + (uintDistanceButtonHeight + uintButtonHeight) * (i) + uintOffsetY,uintButtonWidth,uintButtonHeight);
            [self addSubview:[nsMutArImageView objectAtIndex : i * uintNumCol + j]];
          }
    }
}

//tracy: highlight selected button
- (Boolean) setSelectedButton: (NSUInteger) a_iIndex{
    if(a_iIndex < uintNumRow * uintNumCol){
        [[nsMutArImageView objectAtIndex : a_iIndex] setHighlighted:TRUE];
        return true;
    }
    else
        return false;
}

//tracy: overide
-(BOOL) beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    
    CGPoint touchPoint = [touch locationInView:self];
    UIButton* btn;
    Boolean bFound = false;
    for(int i = 0; (i < uintNumRow * uintNumCol) && (bFound == false); i++) {//for loop
        btn = [nsMutArImageView objectAtIndex : i];
        if(CGRectContainsPoint(btn.frame, touchPoint)){
            [[nsMutArImageView objectAtIndex: i] setHighlighted: TRUE];
            if(uintCurrentTouchIndex < uintNumRow * uintNumCol) {
                [[nsMutArImageView objectAtIndex: uintCurrentTouchIndex] setHighlighted: FALSE];
            }
            uintCurrentTouchIndex = i;
            bFound = true;
        }
    }
    bButtonTouched = bFound;
    if(bFound)
        return YES;
    else
        return FALSE;
}

//tracy: overide
- (void)setHidden:(BOOL)hidden{
    [super setHidden:hidden];
    bButtonTouched = false;
}

@end
