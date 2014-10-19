//
//  TRACYHistoryViewController.m
//  GPLX
//
//  Created by TRACY on 3/9/14.
//  Copyright (c) 2014 TRACY. All rights reserved.
//

#import "TRACYHistoryViewController.h"

@interface TRACYHistoryViewController ()

@end

@implementation TRACYHistoryViewController

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
    [TRACYCoreData clearCoreData : @"Entity"];
    [TRACYCoreData loadDataFromSqliteIntoCoreData: @"TestQuestionSqlite" : @"Entity"];
    mPracticeSession = [[PracticeSession alloc] initHistory:@"Entity"];
    NSNumber* value = [[NSNumber alloc] initWithInt:0] ;
    mAnswersChosen = [[NSMutableArray alloc] init];
    for(int i = 0; i < 4; i++) {
        [mAnswersChosen addObject:value];
    }
    [self showQuestionAtIndex:0];
    self.mPickerQuestion.hidden = YES;
    mIdQuestionPicker = [[NSMutableArray alloc] init];
    for(int i = 0; i < [[mPracticeSession getQuestionCollection] getNumberOfQuestions]; i ++) {
        [mIdQuestionPicker addObject:[[NSString alloc] initWithFormat:@"%d",i+1]];
    }

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnPreviousTapped:(id)sender {
    [mPracticeSession previousQuestion];
    [self showQuestionAtIndex:[mPracticeSession getCurrentIndex]];
}

- (IBAction)btnNextTapped:(id)sender {
    [mPracticeSession nextQuestion];
    [self showQuestionAtIndex:[mPracticeSession getCurrentIndex]];
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
}

- (IBAction)btnHintTapped:(id)sender {
    [self.mBtnHint setTitle:[mQuestionCollection getHintAtIndex:[mPracticeSession getCurrentIndex]] forState:UIControlStateNormal];
}

- (IBAction)btnCurrentIndex:(id)sender {
    //[sender setEnabled:false];
    [sender setHidden:true];
    self.mPickerQuestion.hidden = NO;
}

- (IBAction)btnDeleteTapped:(id)sender {
    [mPracticeSession deleteCurrentFromHistory: [mPracticeSession getCurrentIndex]];
}
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [[mPracticeSession getQuestionCollection] getNumberOfQuestions];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row   forComponent:(NSInteger)component
{
    NSString *a = [mIdQuestionPicker objectAtIndex:row];
    return a;
    //return [[mPracticeSession getQuestionCollection] getIdQuestionAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row   inComponent:(NSInteger)component
{
    [mPracticeSession setCurrentIndex:row];
    [self showQuestionAtIndex:row];
    
}


- (void) showQuestionAtIndex: (NSInteger) currentQuestionIndex {
    if(currentQuestionIndex == [[mPracticeSession getQuestionCollection] getNumberOfQuestions]) {
        self.mBtnNext.enabled = NO;
    }
    else {
        self.mBtnNext.enabled = YES;
    }
    
    [self.mBtnCurrentQuesionIndex setTitle:[[NSString alloc] initWithFormat:@"%@%d", @"Cau hoi so ",[mPracticeSession getCurrentIndex] + 1] forState: UIControlStateNormal];
    [self.mPickerQuestion selectRow:[mPracticeSession getCurrentIndex] inComponent:0 animated:YES];
    mQuestionCollection = [mPracticeSession getQuestionCollection];
    self.mLblQuestion.text = [mQuestionCollection getQuestionAtIndex:currentQuestionIndex];
    for(UIButton* btn in [self mBtnAnswer]) {
        [btn setBackgroundColor:[UIColor whiteColor]];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
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

@end
