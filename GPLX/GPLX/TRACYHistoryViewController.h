//
//  TRACYHistoryViewController.h
//  GPLX
//
//  Created by TRACY on 3/9/14.
//  Copyright (c) 2014 TRACY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PracticeSession.h"
#import "QuestionCollection.h"
@interface TRACYHistoryViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate> {
    PracticeSession* mPracticeSession;
    QuestionCollection* mQuestionCollection;
    NSMutableArray* mAnswersChosen;
    NSMutableArray *mIdQuestionPicker;
}
@property (strong, nonatomic) IBOutlet UIButton *mBtnPrevious;
@property (strong, nonatomic) IBOutlet UIButton *mBtnNext;
@property (strong, nonatomic) IBOutlet UILabel *mLblQuestion;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *mBtnAnswer;
@property (strong, nonatomic) IBOutlet UIButton *mBtnCurrentQuesionIndex;
@property (strong, nonatomic) IBOutlet UIPickerView *mPickerQuestion;
@property (strong, nonatomic) IBOutlet UIButton *mBtnHint;

- (IBAction)btnPreviousTapped:(id)sender;
- (IBAction)btnNextTapped:(id)sender;
- (IBAction)btnAnswerTapped:(id)sender;
- (IBAction)btnResultTapped:(id)sender;
- (IBAction)btnHintTapped:(id)sender;
- (IBAction)btnCurrentIndex:(id)sender;
- (IBAction)btnDeleteTapped:(id)sender;

- (void) showQuestionAtIndex: (NSInteger) currentQuestionIndex;
@end
