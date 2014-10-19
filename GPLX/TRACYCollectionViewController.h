//
//  TRACYViewController.h
//  GPLX
//
//  Created by TRACY on 10/5/14.
//  Copyright (c) 2014 TRACY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRACYMainViewController.h"
#import "PracticeSession.h"
#import "QuestionCollection.h"

#import "UITRACYQuestionBoard.h"//

//tracy:
const float k_fBtnHomeWidth;
extern const float k_fBtnHomeHeight;

extern const float k_fHeightOneLine;
extern const float k_fOffsetX;
extern const float k_fLblQuestionWidthCollection;
extern const float k_fImgViewAnswerWidthCollection;
extern const float k_fImgViewAnswerHeightCollection;
extern const float k_fBtnAnswerWidthCollection;

extern const float k_fScreenWidthCollection;
extern const float k_fBtnShowHideAnswerWidthCollection;
extern const float k_fBtnShowHideAnswerHeightCollection;

extern const float k_fBtnSelectQuestionWidthCollection;//
extern const float k_fBtnSelectQuestionHeightCollection;//

extern const float k_fLblQuestionLblWidthCollection;
extern const float k_fLblQuestionLblHeightCollection;
extern const float k_fLblQuestionIndexHeightCollection;
extern const float k_fScrollViewHeightCollection;

extern const float k_fOffsetXBtnSelectCollection;
extern const float k_fBtnSelectCollectionWidth;
extern const int k_iNumCollection;

extern const NSInteger k_iTagbtnSelectQuestionCollection;
extern const NSInteger k_iTaguiTRACYQuestionBoard;
extern const NSInteger k_iTagbtnSelectCollection;
extern const NSInteger k_iTaguiTRACYChooseCollection;

@interface TRACYCollectionViewController : UIViewController <TRACYQuestionBoardDelegate>
{
    PracticeSession* mPracticeSession;
    QuestionCollection* mQuestionCollection;
    NSMutableArray* mAnswersChosen;
    
    //tracy: question board
    bool m_bRightAnswerHidden;//
    float m_fQuestionBoardWidth;//
    float m_fQuestionBoardHeight;//
    int m_iCollectionType;//
    int m_iNumRowQuestionBoard;//
    int m_iNumRColQuestionBoard;//
    
    //choose collection
    int m_iCurrentQuestionIndex;
    int m_iCurrentCollectionIndex;
}

//tracy:


@property (strong, nonatomic) IBOutlet UIScrollView *scrollViewCollection;


@property (strong, nonatomic) IBOutlet UIButton *btnHomeCollection;
@property (strong, nonatomic) IBOutlet UINavigationBar *navBarCollection;
@property (strong, nonatomic) IBOutlet UILabel *lblQuestionLblCollection;

@property (strong, nonatomic) IBOutlet UILabel *lblQuestionIndexCollection;

@property (strong, nonatomic) IBOutlet UIButton *btnSelectQuestionCollection;//
@property (strong, nonatomic) IBOutlet UIButton *btnSelectCollection;

@property (strong, nonatomic) IBOutlet UILabel *lblQuestionCollection;
@property (strong, nonatomic) IBOutlet UIButton *btnAnswerACollection;
@property (strong, nonatomic) IBOutlet UIButton *btnAnswerBCollection;
@property (strong, nonatomic) IBOutlet UIButton *btnAnswerCCollection;
@property (strong, nonatomic) IBOutlet UIButton *btnAnswerDCollection;
@property (strong, nonatomic) IBOutlet UIButton *btnShowHideAnswerCollection;

@property (strong, nonatomic) IBOutlet UILabel *lblAnswerACollection;
@property (strong, nonatomic) IBOutlet UILabel *lblAnswerBCollection;
@property (strong, nonatomic) IBOutlet UILabel *lblAnswerCCollection;
@property (strong, nonatomic) IBOutlet UILabel *lblAnswerDCollection;


@property (strong, nonatomic) IBOutlet UIImageView *imgViewAnswerACollection;
@property (strong, nonatomic) IBOutlet UIImageView *imgViewAnswerBCollection;
@property (strong, nonatomic) IBOutlet UIImageView *imgViewAnswerCCollection;
@property (strong, nonatomic) IBOutlet UIImageView *imgViewAnswerDCollection;

@property (strong, nonatomic) IBOutlet UITRACYQuestionBoard *uiTRACYQuestionBoard;
@property (strong, nonatomic) IBOutlet UITRACYQuestionBoard *uiTRACYChooseCollection;

- (IBAction)onTouchUpInsideBtnAnswerACollection:(id)sender;
- (IBAction)onTouchUpInsideBtnAnswerBCollection:(id)sender;
- (IBAction)onTouchUpInsideBtnAnswerCCollection:(id)sender;
- (IBAction)onTouchUpInsideBtnAnswerDCollection:(id)sender;
- (IBAction)onTouchDownBtnShowHideAnswerCollection:(id)sender;//

- (IBAction)onTouchUpInsideBtnSelectQuestionCollection:(id)sender;
- (IBAction)onTouchUpInsideBtnSelectQuestionIndexCollection:(id)sender;
- (IBAction)onTouchDownBtnSelectQuestionIndexCollection:(id)sender;

- (IBAction)onTouchUpInsideBtnChooseCollection:(id)sender;
- (IBAction)onTouchDownChooseIndexCollection:(id)sender;
- (IBAction)onTouchUpInsideChooseIndexCollection:(id)sender;


//tracy:

- (void) initInterface;
- (void) initData;
- (void) initLocalVariables;
- (void) startCollection;
- (void) showQuestionAtIndex: (NSInteger) currentQuestionIndex  ofCollection: (NSInteger)currentCollectionIndex;
- (void) showQuestionAtIndex: (NSInteger) currentQuestionIndex;
- (int) getNumLineOfString: (NSString*) str : (UIFont*) font : (float) width;
- (NSInteger) getButtonAnswerIndex: (UIButton*) button;
- (UIButton*) getButtonAnswerWithIndex: (NSInteger) index;

- (void) enableControlsAfterSelecting;
- (void) disableControlsOnSelectingQuestion;
- (void) disableControlsOnSelectingCollection;
@end
