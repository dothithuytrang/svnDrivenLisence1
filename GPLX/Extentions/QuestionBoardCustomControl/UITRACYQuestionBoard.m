//
//  UITRACYQuestionBoard.m
//  testCustomControlQuestionBoard
//
//  Created by TRACY on 9/21/14.
//  Copyright (c) 2014 TRACY. All rights reserved.
//

#import "UITRACYQuestionBoard.h"

@implementation UITRACYQuestionBoard
@synthesize  uintNumRow, uintNumCol, uintCurrentTouchIndex, bButtonTouched;

//tracy: overide
- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    
    ////delegate
    //[self setDelegate:self.delegate];
    
    [self initDefaultValue];
    [self calculateSizeOfElement];
    [self generateButtons];
    [self setButtonTitleWithAutoNumber];
    [self setButtonTitleColor:[UIColor blackColor]];
    return self;

}

- (void) initDefaultValue {
    uintNumRow = 30;
    uintNumCol = 5;
    fPaddingRatio = 0.5;
    fDistanceButtonRatio = 0.5;
    
    mutArrayButtonTitleStringArray = [[NSMutableArray alloc] init];
}
- (void) calculateSizeOfElement{
    
    uintBackgroundWidth = self.frame.size.width;
    uintBackgroundHeight = self.frame.size.height;
    
    uintButtonWidth = uintBackgroundWidth / (uintNumCol*(1+fDistanceButtonRatio) + 2 * fPaddingRatio - fDistanceButtonRatio);
    uintDistanceButtonWidth = uintButtonWidth * fDistanceButtonRatio;
    uintPaddingWidth = uintButtonWidth * fPaddingRatio;
    
    uintButtonHeight = uintBackgroundHeight / (uintNumRow*(1+fDistanceButtonRatio) + 2 * fPaddingRatio - fDistanceButtonRatio);
    uintDistanceButtonHeight = uintButtonHeight * fDistanceButtonRatio;
    uintPaddingHeight = uintButtonHeight * fPaddingRatio;
    
}

- (void) generateButtons {
    nsMutArButtonView = [[NSMutableArray alloc] init];
    for(int i = 0; i < uintNumRow ; i++)
    {
        for(int j = 0; j < uintNumCol ; j++)
        {
            UIButton* btn = [[UIButton alloc] init];
            
            btn.frame = CGRectMake(uintPaddingWidth + (uintDistanceButtonWidth + uintButtonWidth) * j, uintPaddingHeight + (uintDistanceButtonHeight + uintButtonHeight) * (i),uintButtonWidth,uintButtonHeight);
            [btn setUserInteractionEnabled:false];
                [nsMutArButtonView addObject:btn];
            [self addSubview:[nsMutArButtonView objectAtIndex : i * uintNumCol + j]];
        }
    }
}

- (void) removeButtonsFromView {
    NSArray *viewsToRemove = [self subviews];
    for (UIView *v in viewsToRemove) {
        [v removeFromSuperview];
    }
}

- (void) reGenerateButtons { // change of num row and col
    UIButton* btnTmp = [nsMutArButtonView objectAtIndex :0];
    NSArray* arrTmp;
    if (buttonTitleType == stringTitle) {
        arrTmp = [[NSArray alloc] initWithArray: mutArrayButtonTitleStringArray] ;
    }
    
    [self removeButtonsFromView];
    [nsMutArButtonView removeAllObjects];
    [self generateButtons];
    
    //apply old format
    [self setButtonTitleColor:btnTmp.currentTitleColor];
    if(buttonBackgroundType == colorBackground) {
        [self setButtonBackgroundColor:btnTmp.backgroundColor];
    }
    else if (buttonBackgroundType == imageBackground) {
        [self setButtonBackgroundImage:btnTmp.currentBackgroundImage];
        
    }
    if(buttonTitleType == autoNumberTitle) {
        [self setButtonTitleWithAutoNumber];
    }
    else if (buttonTitleType == stringTitle)
    {
        [self setButtonTitleWithStringArray:arrTmp];
    }
    [self setButtonBorderColor:[UIColor colorWithCGColor: btnTmp.layer.borderColor]];
    [self setButtonBorderWidth:btnTmp.layer.borderWidth];
    [self setButtonTitleEdgeInsets:btnTmp.titleEdgeInsets];
    [self setButtonContentHorizontalAlignment:btnTmp.contentHorizontalAlignment];

}


- (void) setButtonTitleWithAutoNumber {
    buttonTitleType = autoNumberTitle;
    for(int i = 0; i < uintNumRow ; i++)
    {
        for(int j = 0; j < uintNumCol ; j++)
        {
            UIButton* btn = [nsMutArButtonView objectAtIndex : i * uintNumCol + j];
            [btn setTitle: [[NSString alloc] initWithFormat:@"%d", i * uintNumCol + j + 1 ] forState:UIControlStateNormal];
        }
    }
}

//todo
- (void) setButtonTitleWithStringArray: (NSArray*) array {
    buttonTitleType = stringTitle;
    [mutArrayButtonTitleStringArray removeAllObjects];
    [mutArrayButtonTitleStringArray addObjectsFromArray:array];
     for(int i = 0; i < uintNumRow ; i++)
     {
         for(int j = 0; j < uintNumCol ; j++)
         {
             UIButton* btn = [nsMutArButtonView objectAtIndex : i * uintNumCol + j];
             NSString *str;
             if([mutArrayButtonTitleStringArray count] > i * uintNumCol + j)
                 str = [array objectAtIndex:i * uintNumCol + j];
             else
                 str = @"No";
             [btn setTitle:str  forState:UIControlStateNormal];
         }
     }
}


- (void) setButtonTitleColor: (UIColor*) color{
    for(int i = 0; i < uintNumRow ; i++)
    {
        for(int j = 0; j < uintNumCol ; j++)
        {
            UIButton* btn = [nsMutArButtonView objectAtIndex : i * uintNumCol + j];
           [btn setTitleColor:color forState:UIControlStateNormal];
            
        }
    }
}

- (void) resizeButtons{
    for(int i = 0; i < uintNumRow ; i++)
    {
        for(int j = 0; j < uintNumCol ; j++)
        {
            UIButton* btn = [nsMutArButtonView objectAtIndex : i * uintNumCol + j];
            
            btn.frame = CGRectMake(uintPaddingWidth + (uintDistanceButtonWidth + uintButtonWidth) * j, uintPaddingHeight + (uintDistanceButtonHeight + uintButtonHeight) * (i),uintButtonWidth,uintButtonHeight);
        }
    }
}

- (void) resetFrame:(CGRect)frame {
    super.frame = frame;
    [self calculateSizeOfElement];
    [self resizeButtons];

}

- (void) setNumRow: (NSUInteger) num{
    uintNumRow = num;
    [self calculateSizeOfElement];
    [self reGenerateButtons];

}

- (void) setNumCol: (NSUInteger) num{
    uintNumCol = num;
    [self calculateSizeOfElement];
    [self reGenerateButtons];
}

- (void) setPaddingRatio: (float) num{
    fPaddingRatio = num;
    [self calculateSizeOfElement];
    [self reGenerateButtons];
}

- (void) setDistanceButtonRatio: (float) num{
    fDistanceButtonRatio = num;
    [self calculateSizeOfElement];
    [self reGenerateButtons];
}

- (void) setButtonBackgroundColor: (UIColor*) color {
    buttonBackgroundType = colorBackground;
    for(int i = 0; i < uintNumRow ; i++)
    {
        for(int j = 0; j < uintNumCol ; j++)
        {
            UIButton* btn = [nsMutArButtonView objectAtIndex : i * uintNumCol + j];
            
            [btn setBackgroundColor: color];
            
        }
    }
}

- (void) setButtonBackgroundImage: (UIImage*) image {
    buttonBackgroundType = imageBackground;
    for(int i = 0; i < uintNumRow ; i++)
    {
        for(int j = 0; j < uintNumCol ; j++)
        {
            UIButton* btn = [nsMutArButtonView objectAtIndex : i * uintNumCol + j];
            [btn setBackgroundImage:image forState:UIControlStateNormal];
            
        }
    }
}

- (void) setButtonBorderColor: (UIColor*) color {
    for(int i = 0; i < uintNumRow ; i++)
    {
        for(int j = 0; j < uintNumCol ; j++)
        {
            UIButton* btn = [nsMutArButtonView objectAtIndex : i * uintNumCol + j];
            btn.layer.borderColor = color.CGColor;
            
        }
    }
}
- (void) setButtonBorderWidth: (float) width {
    for(int i = 0; i < uintNumRow ; i++)
    {
        for(int j = 0; j < uintNumCol ; j++)
        {
            UIButton* btn = [nsMutArButtonView objectAtIndex : i * uintNumCol + j];
            btn.layer.borderWidth = width;
            
        }
    }
}

- (void) setButtonTitleEdgeInsets: (UIEdgeInsets) uiEdgeInsects {
    for(int i = 0; i < uintNumRow ; i++)
    {
        for(int j = 0; j < uintNumCol ; j++)
        {
            UIButton* btn = [nsMutArButtonView objectAtIndex : i * uintNumCol + j];
            [btn setTitleEdgeInsets:uiEdgeInsects];
        }
    }
}
- (void) setButtonContentHorizontalAlignment: (UIControlContentHorizontalAlignment) uiControlContentHorizontalAlignment {
    for(int i = 0; i < uintNumRow ; i++)
    {
        for(int j = 0; j < uintNumCol ; j++)
        {
            UIButton* btn = [nsMutArButtonView objectAtIndex : i * uintNumCol + j];
            btn.contentHorizontalAlignment = uiControlContentHorizontalAlignment;
            
        }
    }
}


/////////////////////



//////////////////


//tracy: highlight selected button
/*
- (Boolean) setSelectedButton: (NSUInteger) a_iIndex{
    if(a_iIndex < uintNumRow * uintNumCol){
        [[nsMutArButtonView objectAtIndex : a_iIndex] setHighlighted:TRUE];
        return true;
    }
    else
        return false;
}
 */

//tracy: overide
-(BOOL) beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    
    CGPoint touchPoint = [touch locationInView:self];
    UIButton* btn;
    Boolean bFound = false;
    for(int i = 0; (i < uintNumRow * uintNumCol) && (bFound == false); i++) {//for loop
        btn = [nsMutArButtonView objectAtIndex : i];
        if(CGRectContainsPoint(btn.frame, touchPoint)){
            [[nsMutArButtonView objectAtIndex: i] setHighlighted: TRUE];
            if(uintCurrentTouchIndex < uintNumRow * uintNumCol) {
                [[nsMutArButtonView objectAtIndex: uintCurrentTouchIndex] setHighlighted: FALSE];
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
    //delegate
    [[self delegate] didSelect];
    [super setHidden:hidden];
    bButtonTouched = false;
}


@end
