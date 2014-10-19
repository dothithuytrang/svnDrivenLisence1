//
//  UITRACYQuestionBoard.h
//  testCustomControlQuestionBoard
//
//  Created by TRACY on 9/21/14.
//  Copyright (c) 2014 TRACY. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum ButtonTitleType : NSUInteger {
    autoNumberTitle,
    stringTitle,
} ButtonTitleType;

typedef enum ButtonBackgroundType : NSUInteger {
    colorBackground,
    imageBackground,
} ButtonBackgroundType;

//delegate
@protocol TRACYQuestionBoardDelegate <NSObject>

@required
- (void) didSelect;

@end

@interface UITRACYQuestionBoard : UIButton
{
    NSUInteger uintNumRow;
    NSUInteger uintNumCol ;
    NSUInteger uintCurrentTouchIndex;
    
    UIImageView* imgViewBackgroundOffset;
    UIImageView* imgViewBackgroundBoard;
    NSMutableArray* nsMutArButtonView;
    
    float uintBackgroundWidth;
    float uintBackgroundHeight;
    float uintButtonWidth;
    float uintButtonHeight;
    float uintDistanceButtonWidth;
    float uintDistanceButtonHeight;
    float uintPaddingWidth;
    float uintPaddingHeight;
    
    float fPaddingRatio;
    float fDistanceButtonRatio;
    
    int countFirstInitWithCoder;
    
    ButtonTitleType buttonTitleType;
    ButtonBackgroundType buttonBackgroundType;
    
    NSMutableArray* mutArrayButtonTitleStringArray;
   
    
}

//delegate
@property (nonatomic, weak) id<TRACYQuestionBoardDelegate> delegate;

//size of images, in pixel
@property (nonatomic) NSUInteger uintNumRow;
@property (nonatomic) NSUInteger uintNumCol ;
@property (nonatomic) NSUInteger uintCurrentTouchIndex;
@property (nonatomic) Boolean bButtonTouched;;


////

- (void) resetFrame:(CGRect)frame;
- (void) setButtonTitleWithAutoNumber;
- (void) setButtonTitleWithStringArray: (NSArray*) array;
- (void) setButtonTitleColor: (UIColor*) color;

- (void) setNumRow: (NSUInteger) num;
- (void) setNumCol: (NSUInteger) num;
- (void) setPaddingRatio: (float) num;
- (void) setDistanceButtonRatio: (float) num;

- (void) setButtonBackgroundColor: (UIColor*) color;
- (void) setButtonBackgroundImage: (UIImage*) image;
- (void) setButtonBorderColor: (UIColor*) color;
- (void) setButtonBorderWidth: (float) width;
- (void) setButtonTitleEdgeInsets: (UIEdgeInsets) uiEdgeInsects;//
- (void) setButtonContentHorizontalAlignment: (UIControlContentHorizontalAlignment) uiControlContentHorizontalAlignment;

//- (Boolean) setSelectedButton: (NSUInteger) a_iIndex;


@end
