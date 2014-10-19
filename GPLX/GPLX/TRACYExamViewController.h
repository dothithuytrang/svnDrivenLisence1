//
//  TRACYExamViewController.h
//  GPLX
//
//  Created by TRACY on 2/28/14.
//  Copyright (c) 2014 TRACY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PracticeSession.h"
#import "QuestionCollection.h"
#import "TRACYMainViewController.h"
#import "TRACYCollectionViewController.h"

@interface TRACYExamViewController : UIViewController <UIAlertViewDelegate> {
    PracticeSession* mPracticeSession;
    QuestionCollection* mQuestionCollection;
    NSInteger mTimer;
    NSMutableString* mCurrentAnswer;
    bool mResultCurrentAnswer;
    NSMutableArray* mAnswersChosen;
    NSInteger totalScore;
    NSTimeInterval startTime;
    bool runningTimer;
    
    UIAlertView *alertViewLastQuestion;
    UIAlertView *alertViewEndTime;
}


@property (strong, nonatomic) IBOutlet UILabel *mLblTimer;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *mBtnCurrentIndex;
@property (strong, nonatomic) IBOutlet UILabel *mLblQuestion;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *mBtnAnswer;
@property (strong, nonatomic) IBOutlet UIButton *mBtnHint;

- (IBAction)btnAnswerTapped:(id)sender;
- (IBAction)btnResultTapped:(id)sender;
- (IBAction)btnHintTapped:(id)sender;


- (void) showQuestionAtIndex: (NSInteger) currentQuestionIndex;
- (void) startExam;
- (void) endExam;
- (void) updateTimer;
//not use timer and date now
@property (strong, nonatomic) NSTimer *stopWatchTimer; // Store the timer that fires after a certain time
@property (strong, nonatomic) NSDate *startDate; // Stores the date of the click on the start button

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex;
@end
