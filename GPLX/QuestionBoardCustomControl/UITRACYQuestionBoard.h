//
//  UITRACYQuestionBoard.h
//  testCustomControlQuestionBoard
//
//  Created by TRACY on 9/21/14.
//  Copyright (c) 2014 TRACY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITRACYQuestionBoard : UIButton
{
    
    NSUInteger uintOffsetY;
    NSUInteger uintNumRow;
    NSUInteger uintNumCol ;
    NSUInteger uintCurrentTouchIndex;
    
    UIImageView* imgViewBackgroundOffset;
    UIImageView* imgViewBackgroundBoard;
    NSMutableArray* nsMutArImageView;
    
    NSUInteger uintBackgroundWidth;
    NSUInteger uintBackgroundHeight;
    NSUInteger uintButtonWidth;
    NSUInteger uintButtonHeight;
    NSUInteger uintDistanceButtonWidth;
    NSUInteger uintDistanceButtonHeight;
    NSUInteger uintPaddingWidth;
    NSUInteger uintPaddingHeight;
   
    
}

//size of images, in pixel
@property (nonatomic) NSUInteger uintOffsetY;
@property (nonatomic) NSUInteger uintNumRow;
@property (nonatomic) NSUInteger uintNumCol ;
@property (nonatomic) NSUInteger uintCurrentTouchIndex;
@property (nonatomic) Boolean bButtonTouched;;


- (void) initStretched: (NSUInteger) a_uintOffsetY : (NSUInteger) a_uintNumRow : (NSUInteger) a_uintNumCol : (float) a_fPaddingRatio : (float) a_fDistanceButtonRatio;

- (void) initImages;
- (void) render;
- (Boolean) setSelectedButton: (NSUInteger) a_iIndex;


@end
