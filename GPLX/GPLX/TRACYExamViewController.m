//
//  TRACYExamViewController.m
//  GPLX
//
//  Created by TRACY on 2/28/14.
//  Copyright (c) 2014 TRACY. All rights reserved.
//

#import "TRACYExamViewController.h"

@interface TRACYExamViewController ()

@end

@implementation TRACYExamViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [TRACYCoreData clearCoreData : @"Entity"];
    [TRACYCoreData loadDataFromSqliteIntoCoreData: @"TestQuestionSqlite" : @"Entity"];
    mPracticeSession = [[PracticeSession alloc] init];
    [self startExam];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnAnswerTapped:(id)sender {
    
    NSInteger indexBtnTapped = [[NSNumber numberWithInteger:[sender tag]] integerValue];
    if(([mAnswersChosen objectAtIndex:indexBtnTapped]) == ([[NSNumber alloc] initWithInt:1])) {
        [mAnswersChosen replaceObjectAtIndex:indexBtnTapped withObject:[[NSNumber alloc] initWithInt:0]];
        [sender setBackgroundColor: [UIColor whiteColor]];
    }
    else {
        [mAnswersChosen replaceObjectAtIndex:indexBtnTapped withObject:[[NSNumber alloc] initWithInt:1]];
        [sender setBackgroundColor: [UIColor blueColor]];
    }
}

- (IBAction)btnResultTapped:(id)sender {
    NSMutableArray* rightAnswer = [[mPracticeSession getQuestionCollection] getRightAnswerAtIndex: [mPracticeSession getCurrentIndex]];
    for(NSNumber* value in rightAnswer) {
        for(UIButton* btn in [self mBtnAnswer]) {
            if(btn.tag == [value integerValue]) {
                [btn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
            }
        }
    }
    NSMutableArray *tmp = [[NSMutableArray alloc] init];
    int i = 0;
    for(NSNumber *answ in mAnswersChosen) {
        if(answ == [[NSNumber alloc] initWithInt:1]) {
            NSNumber* value = [[NSNumber alloc] initWithInt:i];
            [tmp addObject:value];
        }
        i++;
    }
    bool right = [mPracticeSession compareTwoAnswer:tmp:rightAnswer];
    
        for(UIButton* btn in self.mBtnCurrentIndex) {
            if(btn.tag == [mPracticeSession getCurrentIndex]) {
                if(right == true) {
                    [btn setBackgroundColor:[UIColor greenColor]];
                    totalScore++;
                }
                else {
                    [btn setBackgroundColor:[UIColor redColor]];
                }
                break;
            }
        }
    bool isAvailableNextQuestion = [mPracticeSession nextQuestion];
    if(isAvailableNextQuestion) {
        [self showQuestionAtIndex:[mPracticeSession getCurrentIndex]];
    }
    else {
        alertViewLastQuestion = [[UIAlertView alloc] initWithTitle: @"Congratulation, you finished exam"
        message:@" Do you want to start new exam?"
    delegate:self
    cancelButtonTitle:@"OK"
    otherButtonTitles:@"Cancel", nil];
        [alertViewLastQuestion show];
        [self endExam];
    }
    
}

- (IBAction)btnHintTapped:(id)sender {
     [self.mBtnHint setTitle:[mQuestionCollection getHintAtIndex:[mPracticeSession getCurrentIndex]] forState:UIControlStateNormal];
}

- (void) showQuestionAtIndex: (NSInteger) currentQuestionIndex {
    for(UIButton* btn in self.mBtnCurrentIndex) {
        if(btn.tag == currentQuestionIndex) {
            [btn setBackgroundColor:[UIColor whiteColor]];

             break;
        }
    }
    mQuestionCollection = [mPracticeSession getQuestionCollection];
    self.mLblQuestion.text = [mQuestionCollection getQuestionAtIndex:currentQuestionIndex];
    for(UIButton* btn in [self mBtnAnswer]) {
        [btn setBackgroundColor:[UIColor whiteColor]];
         [btn setTitleColor:[UIColor blueColor ] forState:UIControlStateNormal];
        switch(btn.tag) {
            case 0:
                [btn setTitle :[mQuestionCollection getAnswerAAtIndex:currentQuestionIndex] forState:UIControlStateNormal];
                break;
            case 1:
                [btn setTitle :[mQuestionCollection getAnswerBAtIndex:currentQuestionIndex] forState:UIControlStateNormal];
                break;
            case 2:
                [btn setTitle :[mQuestionCollection getAnswerCAtIndex:currentQuestionIndex] forState:UIControlStateNormal];
                break;
            case 3:
                [btn setTitle :[mQuestionCollection getAnswerDAtIndex:currentQuestionIndex] forState:UIControlStateNormal];
                break;
        }
    }
    [self.mBtnHint setTitle:@"Hint" forState:UIControlStateNormal];
    NSNumber* value = [[NSNumber alloc] initWithInt:0] ;
    for(int i = 0; i < 4; i++) {
        [mAnswersChosen replaceObjectAtIndex:i withObject:value];
    }

}
- (void) startExam {
    PracticeSession *tmpPracticeSession = [[PracticeSession alloc] initWithEntityAndNumber: @"Entity": 5];
    totalScore = 0;
       mPracticeSession = tmpPracticeSession;
    NSNumber* value = [[NSNumber alloc] initWithInt:0] ;
    mAnswersChosen = [[NSMutableArray alloc] init];
    for(int i = 0; i < 4; i++) {
        [mAnswersChosen addObject:value];
    }
    [self showQuestionAtIndex:0];
    for(UIButton* btn in self.mBtnCurrentIndex) {
        [btn setBackgroundColor: [UIColor lightGrayColor]];
    }
    startTime = [NSDate timeIntervalSinceReferenceDate];
    runningTimer = true;
    self.mLblTimer.text = @"00:00:00";
    [self updateTimer];
}
- (void) endExam {
    //[mPracticeSession removeAll];
}
- (void) updateTimer {
    if(runningTimer == true) {
    NSTimeInterval currentTime = [NSDate timeIntervalSinceReferenceDate];
    NSTimeInterval elapsed = currentTime - startTime;
        if(elapsed>120) {
            runningTimer = false;
            alertViewEndTime = [[UIAlertView alloc] initWithTitle: @"Time End"
                                                               message:@" Do you want to start new exam?"
                                                              delegate:self
                                                     cancelButtonTitle:@"OK"
                                                     otherButtonTitles:@"Cancel", nil];
            [alertViewEndTime show];
        }
        else {
    int mins = (int) (elapsed/60.0);
    elapsed -= mins*60;
    int secs = (int) (elapsed);
    elapsed -= secs;
    int fraction = elapsed * 10.0;
    self.mLblTimer.text = [[NSString alloc] initWithFormat:@"%u:%02u.%u",mins,secs,fraction];
    [self performSelector:@selector(updateTimer) withObject:self afterDelay:0.1];
    //[elapsed invalidate];
        }
    }
    
}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        
        [self startExam];
    }
    if (buttonIndex == 1) {
      [self performSegueWithIdentifier: @"examBackToMainMenu" sender: self];
    }
}
@end
