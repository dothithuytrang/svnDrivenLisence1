//
//  TRACYViewController.m
//  GPLX
//
//  Created by TRACY on 10/5/14.
//  Copyright (c) 2014 TRACY. All rights reserved.
//

#import "TRACYCollectionViewController.h"

//tracy:
const float k_fBtnHomeWidth = 37;
const float k_fBtnHomeHeight = 29.5;

const float k_fHeightOneLine = 25;
const float k_fOffsetX = 15;
const float k_fLblQuestionWidthCollection =  300;
const float k_fImgViewAnswerWidthCollection = 25;
const float k_fImgViewAnswerHeightCollection = 20;
const float k_fBtnAnswerWidthCollection =  280;

const float k_fScreenWidthCollection = 320;
const float k_fBtnShowHideAnswerWidthCollection = 142;
const float k_fBtnShowHideAnswerHeightCollection =30;

const float k_fBtnSelectQuestionWidthCollection = 81;//
const float k_fBtnSelectQuestionHeightCollection = 30;//

const float k_fLblQuestionLblWidthCollection = 63;
const float k_fLblQuestionLblHeightCollection = 21;
const float k_fLblQuestionIndexHeightCollection = 10;

const float k_fScrollViewHeightCollection = 2000;
const float k_fStatusBarHeightCollection = 20;

const float k_fOffsetXBtnSelectCollection = 227;
const float k_fBtnSelectCollectionWidth = 81;
const int k_iNumCollection = 12;

const NSInteger k_iTagbtnSelectQuestionCollection = 0;
const NSInteger k_iTaguiTRACYQuestionBoard  = 1;
const NSInteger k_iTagbtnSelectCollection = 2;
const NSInteger k_iTaguiTRACYChooseCollection = 3;

@interface TRACYCollectionViewController ()

@end

@implementation TRACYCollectionViewController

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
    // Do any additional setup after loading the view.
    
    //delegate
    [self.uiTRACYQuestionBoard setDelegate:self];
    [self.uiTRACYChooseCollection setDelegate:self];
    
    //tracy: init interface
        //tracy: init database
    [self initData];
    [self initLocalVarialbes];
    [self initInterface];
    //tracy: start collection with first question
    [self startExam];
    
    
}

- (void) initInterface {
    
    UIImage *uiimage;
    
//set background color for main view
    [self.view setBackgroundColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:195/255.0 alpha:1]];
    
//tracy: set properties for navigation bar----------
    self.navBarCollection.frame = CGRectMake(0, k_fStatusBarHeightCollection, k_fScreenWidthCollection, self.navBarCollection.frame.size.height);
    uiimage = [UIImage imageNamed:@"navBarBackgroundCollection.png"];
    [self.navBarCollection setBackgroundImage:uiimage forBarMetrics:UIBarMetricsDefault];
    
//button home----------
    uiimage = [UIImage imageNamed:@"btnHomeCollection.png"];
    [self.btnHomeCollection setTitle:@"" forState:UIControlStateNormal];
    [self.btnHomeCollection setBackgroundImage:uiimage forState:UIControlStateNormal];
    self.btnHomeCollection.frame = CGRectMake(k_fOffsetX, 40, k_fBtnHomeWidth , k_fBtnHomeHeight);
//scroll view----------
    [self.scrollViewCollection setScrollEnabled:true];
    [self.scrollViewCollection setContentSize:CGSizeMake(k_fScreenWidthCollection, k_fScrollViewHeightCollection)];
    [self.scrollViewCollection setCanCancelContentTouches:true];
    self.scrollViewCollection.delaysContentTouches = true;
    
//question index----------
    self.lblQuestionIndexCollection.frame = CGRectMake(k_fOffsetX + self.lblQuestionLblCollection.frame.size.width + 3, self.lblQuestionLblCollection.frame.origin.y,k_fLblQuestionIndexHeightCollection, self.lblQuestionLblCollection.frame.size.height);
    
//question----------
    self.lblQuestionLblCollection.frame = CGRectMake(k_fOffsetX, k_fHeightOneLine/2.0, k_fLblQuestionLblWidthCollection, k_fLblQuestionLblHeightCollection);
    
//button select question----------
    [self.btnSelectQuestionCollection setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btnSelectQuestionCollection setTitle:@"1/150" forState:UIControlStateNormal];
    [self.btnSelectQuestionCollection setBackgroundImage:[UIImage imageNamed:@"btnSelectQuestionCollection.png"] forState:UIControlStateNormal];
    [self.btnSelectQuestionCollection setTag: k_iTagbtnSelectQuestionCollection];

    
    self.btnSelectQuestionCollection.frame = CGRectMake((k_fScreenWidthCollection - k_fBtnSelectQuestionWidthCollection)/2, self.lblQuestionIndexCollection.frame.origin.y + self.lblQuestionIndexCollection.frame.size.height/2 - k_fBtnShowHideAnswerHeightCollection/2, k_fBtnSelectQuestionWidthCollection, k_fBtnSelectQuestionHeightCollection);
    [self.btnSelectQuestionCollection setTitleEdgeInsets:UIEdgeInsetsMake(0, 5.0, 0, 0)];
    
//custom control select question----------
    [self.uiTRACYQuestionBoard setTag:k_iTaguiTRACYQuestionBoard];
    [self.uiTRACYQuestionBoard setBackgroundColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:195/255.0 alpha:1]];
    self.uiTRACYQuestionBoard.layer.borderWidth = 2.0f;
    self.uiTRACYQuestionBoard.layer.borderColor = [UIColor blackColor].CGColor;
    self.uiTRACYQuestionBoard.layer.borderWidth = 1.0f;
    CGRect rect = CGRectMake(k_fOffsetX, self.btnSelectQuestionCollection.frame.origin.y + self.btnSelectQuestionCollection.frame.size.height, m_fQuestionBoardWidth, m_fQuestionBoardHeight);
    [self.uiTRACYQuestionBoard resetFrame: rect];
    [self.uiTRACYQuestionBoard setNumRow: 30];
    [self.uiTRACYQuestionBoard setNumCol: 5];
    [self.uiTRACYQuestionBoard setDistanceButtonRatio: 0.2];
    [self.uiTRACYQuestionBoard setButtonBackgroundImage:[UIImage imageNamed:@"btnSelectQuestionBoardCollection"]];
    [self.uiTRACYQuestionBoard setButtonTitleWithAutoNumber];
    [self.uiTRACYQuestionBoard setButtonContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    
    [self.uiTRACYQuestionBoard setHidden:true];
    
//button select collection----------
    [self.btnSelectCollection setTag: k_iTagbtnSelectCollection];
    [self.btnSelectCollection setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btnSelectCollection setTitle:@"Tất cả" forState:UIControlStateNormal];
    [self.btnSelectCollection setBackgroundImage:[UIImage imageNamed:@"btnSelectQuestionCollection.png"] forState:UIControlStateNormal];
    self.btnSelectCollection.frame = CGRectMake(k_fOffsetXBtnSelectCollection,self.btnSelectQuestionCollection.frame.origin.y,k_fBtnSelectCollectionWidth,self.btnSelectQuestionCollection.frame.size.height);
    [self.btnSelectCollection setTitleEdgeInsets:UIEdgeInsetsMake(0, 10.0, 0, 0)];
    self.btnSelectCollection.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
//custom control list to select collection
    [self.uiTRACYChooseCollection setTag: k_iTaguiTRACYChooseCollection];
    [self.uiTRACYChooseCollection resetFrame: CGRectMake(k_fOffsetXBtnSelectCollection,self.btnSelectQuestionCollection.frame.origin.y + self.btnSelectQuestionCollection.frame.size.height,k_fBtnSelectCollectionWidth,self.btnSelectQuestionCollection.frame.size.height  * 3)];
    [self.uiTRACYChooseCollection setNumRow: 3];
    [self.uiTRACYChooseCollection setNumCol: 1];
    [self.uiTRACYChooseCollection setDistanceButtonRatio: 0];
    [self.uiTRACYChooseCollection setPaddingRatio: 0];
    [self.uiTRACYChooseCollection setButtonBackgroundColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:112/255.0 alpha:1]];
    [self.uiTRACYChooseCollection setButtonBorderColor:[UIColor blackColor]];
    [self.uiTRACYChooseCollection setButtonBorderWidth:1.0f];
    [self.uiTRACYChooseCollection setButtonTitleEdgeInsets:UIEdgeInsetsMake(0, 10.0, 0, 0)];
    [self.uiTRACYChooseCollection setButtonContentHorizontalAlignment: UIControlContentHorizontalAlignmentLeft];
    NSArray* array = [[NSArray alloc] initWithObjects:@"Tat ca", @"Cau sai", nil];
    [self.uiTRACYChooseCollection setButtonTitleWithStringArray:array];
    [self.uiTRACYChooseCollection setHidden:true];
    
//question
    self.lblQuestionCollection.lineBreakMode = NSLineBreakByWordWrapping;
    self.lblQuestionCollection.numberOfLines = 0;
    
//answer index
    self.lblAnswerACollection.text = @" A";
    [self.imgViewAnswerACollection setImage:[UIImage imageNamed:@"imgViewAnswerSelectedCollection.png"]];
    self.imgViewAnswerACollection.hidden = TRUE;
    self.lblAnswerBCollection.text = @" B";
    [self.imgViewAnswerBCollection setImage:[UIImage imageNamed:@"imgViewAnswerSelectedCollection.png"]];
    self.imgViewAnswerBCollection.hidden = TRUE;
    self.lblAnswerCCollection.text = @" C";
    [self.imgViewAnswerCCollection setImage:[UIImage imageNamed:@"imgViewAnswerSelectedCollection.png"]];
    self.imgViewAnswerCCollection.hidden = TRUE;
    self.lblAnswerDCollection.text = @" D";
    [self.imgViewAnswerDCollection setImage:[UIImage imageNamed:@"imgViewAnswerSelectedCollection.png"]];
    self.imgViewAnswerDCollection.hidden = TRUE;
    
//answer
    self.btnAnswerACollection.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.btnAnswerACollection.titleLabel.textAlignment  = NSTextAlignmentCenter;
    self.btnAnswerBCollection.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.btnAnswerBCollection.titleLabel.textAlignment  = NSTextAlignmentCenter;
    self.btnAnswerCCollection.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.btnAnswerCCollection.titleLabel.textAlignment  = NSTextAlignmentCenter;
    self.btnAnswerDCollection.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.btnAnswerDCollection.titleLabel.textAlignment  = NSTextAlignmentCenter;
    
    [self.btnAnswerACollection setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btnAnswerBCollection setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btnAnswerCCollection setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btnAnswerDCollection setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

//button show/hide right answer
    [self.btnShowHideAnswerCollection setTitle:@"" forState:UIControlStateNormal];
    [self.btnShowHideAnswerCollection setBackgroundImage:[UIImage imageNamed:@"btnShowRightAnswerCollection.png"] forState:UIControlStateNormal];
    
}
- (void) initData {
    [TRACYCoreData clearCoreData : @"Entity"];
    [TRACYCoreData loadDataFromSqliteIntoCoreData: @"TestQuestionSqlite" : @"Entity"];
    mPracticeSession = [[PracticeSession alloc] init];
    mQuestionCollection = [mPracticeSession getQuestionCollection];
    
    m_iCurrentCollectionIndex = 0;
    PracticeSession *tmpPracticeSession = [[PracticeSession alloc] initAllWithEntity: @"Entity"];
    
    m_iCurrentCollectionIndex = 2;
    //tmpPracticeSession = [[PracticeSession alloc] initAllWithEntity: @"Entity"];
    tmpPracticeSession = [[PracticeSession alloc] initCollectionWithEntity: @"Entity": m_iCurrentCollectionIndex];
    
    mPracticeSession = tmpPracticeSession;
    mQuestionCollection = [mPracticeSession getQuestionCollection];
    NSNumber* value = [[NSNumber alloc] initWithInt:0] ;
    mAnswersChosen = [[NSMutableArray alloc] init];
    for(int i = 0; i < 4; i++) {
        [mAnswersChosen addObject:value];
    }
    
}
//
- (void) initLocalVarialbes {
    m_bRightAnswerHidden = true;
    //
    //tracy: question board
    switch (m_iCollectionType) {
        case 0:
            m_fQuestionBoardWidth = 290;
            m_fQuestionBoardHeight = 1680;
            m_iNumRowQuestionBoard = 30;
            m_iNumRColQuestionBoard = 5;
            break;
        default:
            m_fQuestionBoardWidth = 0;
            m_fQuestionBoardHeight = 0;
            m_iNumRowQuestionBoard = 0;
            m_iNumRColQuestionBoard = 0;
    }
    //
}//
- (void) startExam {
    m_iCurrentQuestionIndex = 0;
    m_iCurrentCollectionIndex = 0;
    [self showQuestionAtIndex:0];
    //todo
    [self showQuestionAtIndex:m_iCurrentQuestionIndex  ofCollection: m_iCurrentCollectionIndex];
}

- (void) showQuestionAtIndex: (NSInteger) currentQuestionIndex  ofCollection: (NSInteger)currentCollectionIndex {
    
    m_iCurrentQuestionIndex = currentQuestionIndex;
    m_iCurrentCollectionIndex = currentCollectionIndex;
    
    //index question and question--------------
    self.lblQuestionIndexCollection.text = [NSString stringWithFormat:@"%d",currentQuestionIndex + 1];
    self.lblQuestionCollection.text = [mQuestionCollection getQuestionAtIndex:currentQuestionIndex];
    //todo [mQuestionCollection getQuestionAtIndex:currentQuestionIndex ofCollection: currentCollectionIndex];
    int numLineQuestion = [self getNumLineOfString:self.lblQuestionCollection.text :self.lblQuestionCollection.font : k_fLblQuestionWidthCollection];
    self.lblQuestionCollection.frame = CGRectMake(k_fOffsetX, self.lblQuestionIndexCollection.frame.origin.y + k_fHeightOneLine, k_fBtnAnswerWidthCollection, numLineQuestion * k_fHeightOneLine);
    
    [self.btnSelectQuestionCollection setTitle:[NSString stringWithFormat:@"%d%@%d", self.uiTRACYQuestionBoard.uintCurrentTouchIndex + 1, @"/", 150] forState:UIControlStateNormal];
    
    //answer--------------
    [self.btnAnswerACollection setTitle: [mQuestionCollection getAnswerAAtIndex:currentQuestionIndex] forState: UIControlStateNormal];
    [self.btnAnswerBCollection setTitle: [mQuestionCollection getAnswerBAtIndex:currentQuestionIndex] forState: UIControlStateNormal];
    [self.btnAnswerCCollection setTitle: [mQuestionCollection getAnswerCAtIndex:currentQuestionIndex] forState: UIControlStateNormal];
    [self.btnAnswerDCollection setTitle: [mQuestionCollection getAnswerDAtIndex:currentQuestionIndex] forState: UIControlStateNormal];
    
    
    //set position for button answer A, B, C, D
    int numLineAnswerA = [self getNumLineOfString:self.btnAnswerACollection.currentTitle :self.btnAnswerACollection.titleLabel.font : k_fBtnAnswerWidthCollection];
    
    self.btnAnswerACollection.frame = CGRectMake(k_fOffsetX + k_fImgViewAnswerWidthCollection, self.lblQuestionCollection.frame.origin.y + self.lblQuestionCollection.frame.size.height , k_fLblQuestionWidthCollection- k_fImgViewAnswerWidthCollection - k_fOffsetX,  numLineAnswerA * k_fHeightOneLine);
    
    int numLineAnswerB = [self getNumLineOfString:self.btnAnswerBCollection.currentTitle :self.btnAnswerBCollection.titleLabel.font : k_fBtnAnswerWidthCollection];
    self.btnAnswerBCollection.frame = CGRectMake(k_fOffsetX + k_fImgViewAnswerWidthCollection, self.btnAnswerACollection.frame.origin.y + self.btnAnswerACollection.frame.size.height , k_fLblQuestionWidthCollection - k_fImgViewAnswerWidthCollection - k_fOffsetX, numLineAnswerB *  k_fHeightOneLine);
    
    int numLineAnswerC = [self getNumLineOfString:self.btnAnswerCCollection.currentTitle :self.btnAnswerCCollection.titleLabel.font : k_fBtnAnswerWidthCollection];
    self.btnAnswerCCollection.frame = CGRectMake(k_fOffsetX + k_fImgViewAnswerWidthCollection, self.btnAnswerBCollection.frame.origin.y + self.btnAnswerBCollection.frame.size.height , k_fLblQuestionWidthCollection - k_fImgViewAnswerWidthCollection - k_fOffsetX, numLineAnswerC *  k_fHeightOneLine);
    
    int numLineAnswerD = [self getNumLineOfString:self.btnAnswerDCollection.currentTitle :self.btnAnswerDCollection.titleLabel.font : k_fBtnAnswerWidthCollection];
    self.btnAnswerDCollection.frame = CGRectMake(k_fOffsetX + k_fImgViewAnswerWidthCollection, self.btnAnswerCCollection.frame.origin.y + self.btnAnswerCCollection.frame.size.height , k_fLblQuestionWidthCollection - k_fImgViewAnswerWidthCollection - k_fOffsetX, numLineAnswerD *  k_fHeightOneLine);
    
    //answer index --------------
    //set position for uiimage, label A, B, C, D
    self.imgViewAnswerACollection.frame = CGRectMake(k_fOffsetX, self.btnAnswerACollection.frame.origin.y + self.btnAnswerACollection.frame.size.height/2.0 - k_fImgViewAnswerHeightCollection/2.0, k_fImgViewAnswerHeightCollection, k_fImgViewAnswerHeightCollection);
    self.lblAnswerACollection.frame = self.imgViewAnswerACollection.frame;
    
    
    self.imgViewAnswerBCollection.frame = CGRectMake(k_fOffsetX, self.btnAnswerBCollection.frame.origin.y + self.btnAnswerBCollection.frame.size.height/2.0 - k_fImgViewAnswerHeightCollection/2.0, k_fImgViewAnswerHeightCollection, k_fImgViewAnswerHeightCollection);
    self.lblAnswerBCollection.frame = self.imgViewAnswerBCollection.frame;
    
    self.imgViewAnswerCCollection.frame = CGRectMake(k_fOffsetX, self.btnAnswerCCollection.frame.origin.y + self.btnAnswerCCollection.frame.size.height/2.0 - k_fImgViewAnswerHeightCollection/2.0, k_fImgViewAnswerHeightCollection, k_fImgViewAnswerHeightCollection);
    self.lblAnswerCCollection.frame = self.imgViewAnswerCCollection.frame;
    
    self.imgViewAnswerDCollection.frame = CGRectMake(k_fOffsetX, self.btnAnswerDCollection.frame.origin.y + self.btnAnswerDCollection.frame.size.height/2.0 - k_fImgViewAnswerHeightCollection/2.0, k_fImgViewAnswerHeightCollection, k_fImgViewAnswerHeightCollection);
    self.lblAnswerDCollection.frame = self.imgViewAnswerDCollection.frame;
    
    self.btnShowHideAnswerCollection.frame = CGRectMake((k_fScreenWidthCollection - k_fBtnShowHideAnswerWidthCollection)/2, self.btnAnswerDCollection.frame.origin.y + self.btnAnswerDCollection.frame.size.height + 2 * k_fHeightOneLine, k_fBtnShowHideAnswerWidthCollection, k_fBtnShowHideAnswerHeightCollection);
    //
    NSNumber* value = [[NSNumber alloc] initWithInt:0] ;
    for(int i = 0; i < 4; i++) {
        [mAnswersChosen replaceObjectAtIndex:i withObject:value];
    }
}
- (void) showQuestionAtIndex: (NSInteger) currentQuestionIndex {
    
    ////////
    //bo di TEST NUMBER OF LINE OF QUESTION AND ANSWER
    
    self.lblQuestionCollection.text = @"lskfdsgd ssfsd saf sdfsf fdfsf dsfasd grtd fdgsfg dfghkhkhyiuyiugiholihughukgyoihougtugiug";
    [self.btnAnswerACollection setTitle:@"LSKDFJLSKFJL LSKDFJLS LSDJFSL LSDFJLS FSLDFKSJerde df lkdjfla lsdjfla ldsfj ldksjf lsadjflasdfj asldjfalsdjflaksdjf sladjfklsajf" forState:UIControlStateNormal];
    [self.btnAnswerBCollection setTitle:@"JLS FSLDFKSJFDLKF SLFJSL LSKDFJALSKFJKJ" forState:UIControlStateNormal];
    
    [self.btnAnswerCCollection setTitle:@"LSDFJLS FSLDFFJSL LSKDFJALSKFJKJ" forState:UIControlStateNormal];
    [self.btnAnswerDCollection setTitle:@"LSKDJLS FSLDFKSJFDLKF SLFJSL LSKDFJALSKFJKJ" forState:UIControlStateNormal];
    
    /////////
    m_iCurrentQuestionIndex = currentQuestionIndex;
    //index question and question--------------
    self.lblQuestionIndexCollection.text = [NSString stringWithFormat:@"%d",currentQuestionIndex + 1];
    self.lblQuestionCollection.text = [mQuestionCollection getQuestionAtIndex:currentQuestionIndex];
    int numLineQuestion = [self getNumLineOfString:self.lblQuestionCollection.text :self.lblQuestionCollection.font : k_fLblQuestionWidthCollection];
    self.lblQuestionCollection.frame = CGRectMake(k_fOffsetX, self.lblQuestionIndexCollection.frame.origin.y + k_fHeightOneLine, k_fBtnAnswerWidthCollection, numLineQuestion * k_fHeightOneLine);
    
    [self.btnSelectQuestionCollection setTitle:[NSString stringWithFormat:@"%d%@%d", self.uiTRACYQuestionBoard.uintCurrentTouchIndex + 1, @"/", 150] forState:UIControlStateNormal];
    
    //answer--------------
    [self.btnAnswerACollection setTitle: [mQuestionCollection getAnswerAAtIndex:currentQuestionIndex] forState: UIControlStateNormal];
    [self.btnAnswerBCollection setTitle: [mQuestionCollection getAnswerBAtIndex:currentQuestionIndex] forState: UIControlStateNormal];
    [self.btnAnswerCCollection setTitle: [mQuestionCollection getAnswerCAtIndex:currentQuestionIndex] forState: UIControlStateNormal];
    [self.btnAnswerDCollection setTitle: [mQuestionCollection getAnswerDAtIndex:currentQuestionIndex] forState: UIControlStateNormal];
   
    
    //set position for button answer A, B, C, D
    int numLineAnswerA = [self getNumLineOfString:self.btnAnswerACollection.currentTitle :self.btnAnswerACollection.titleLabel.font : k_fBtnAnswerWidthCollection];
    
    self.btnAnswerACollection.frame = CGRectMake(k_fOffsetX + k_fImgViewAnswerWidthCollection, self.lblQuestionCollection.frame.origin.y + self.lblQuestionCollection.frame.size.height , k_fLblQuestionWidthCollection- k_fImgViewAnswerWidthCollection - k_fOffsetX,  numLineAnswerA * k_fHeightOneLine);
    
    int numLineAnswerB = [self getNumLineOfString:self.btnAnswerBCollection.currentTitle :self.btnAnswerBCollection.titleLabel.font : k_fBtnAnswerWidthCollection];
    self.btnAnswerBCollection.frame = CGRectMake(k_fOffsetX + k_fImgViewAnswerWidthCollection, self.btnAnswerACollection.frame.origin.y + self.btnAnswerACollection.frame.size.height , k_fLblQuestionWidthCollection - k_fImgViewAnswerWidthCollection - k_fOffsetX, numLineAnswerB *  k_fHeightOneLine);
    
    int numLineAnswerC = [self getNumLineOfString:self.btnAnswerCCollection.currentTitle :self.btnAnswerCCollection.titleLabel.font : k_fBtnAnswerWidthCollection];
    self.btnAnswerCCollection.frame = CGRectMake(k_fOffsetX + k_fImgViewAnswerWidthCollection, self.btnAnswerBCollection.frame.origin.y + self.btnAnswerBCollection.frame.size.height , k_fLblQuestionWidthCollection - k_fImgViewAnswerWidthCollection - k_fOffsetX, numLineAnswerC *  k_fHeightOneLine);
    
    int numLineAnswerD = [self getNumLineOfString:self.btnAnswerDCollection.currentTitle :self.btnAnswerDCollection.titleLabel.font : k_fBtnAnswerWidthCollection];
    self.btnAnswerDCollection.frame = CGRectMake(k_fOffsetX + k_fImgViewAnswerWidthCollection, self.btnAnswerCCollection.frame.origin.y + self.btnAnswerCCollection.frame.size.height , k_fLblQuestionWidthCollection - k_fImgViewAnswerWidthCollection - k_fOffsetX, numLineAnswerD *  k_fHeightOneLine);
    
    //answer index --------------
    //set position for uiimage, label A, B, C, D
    self.imgViewAnswerACollection.frame = CGRectMake(k_fOffsetX, self.btnAnswerACollection.frame.origin.y + self.btnAnswerACollection.frame.size.height/2.0 - k_fImgViewAnswerHeightCollection/2.0, k_fImgViewAnswerHeightCollection, k_fImgViewAnswerHeightCollection);
    self.lblAnswerACollection.frame = self.imgViewAnswerACollection.frame;
    
    
    self.imgViewAnswerBCollection.frame = CGRectMake(k_fOffsetX, self.btnAnswerBCollection.frame.origin.y + self.btnAnswerBCollection.frame.size.height/2.0 - k_fImgViewAnswerHeightCollection/2.0, k_fImgViewAnswerHeightCollection, k_fImgViewAnswerHeightCollection);
    self.lblAnswerBCollection.frame = self.imgViewAnswerBCollection.frame;
    
    self.imgViewAnswerCCollection.frame = CGRectMake(k_fOffsetX, self.btnAnswerCCollection.frame.origin.y + self.btnAnswerCCollection.frame.size.height/2.0 - k_fImgViewAnswerHeightCollection/2.0, k_fImgViewAnswerHeightCollection, k_fImgViewAnswerHeightCollection);
    self.lblAnswerCCollection.frame = self.imgViewAnswerCCollection.frame;
    
    self.imgViewAnswerDCollection.frame = CGRectMake(k_fOffsetX, self.btnAnswerDCollection.frame.origin.y + self.btnAnswerDCollection.frame.size.height/2.0 - k_fImgViewAnswerHeightCollection/2.0, k_fImgViewAnswerHeightCollection, k_fImgViewAnswerHeightCollection);
    self.lblAnswerDCollection.frame = self.imgViewAnswerDCollection.frame;
    
    self.btnShowHideAnswerCollection.frame = CGRectMake((k_fScreenWidthCollection - k_fBtnShowHideAnswerWidthCollection)/2, self.btnAnswerDCollection.frame.origin.y + self.btnAnswerDCollection.frame.size.height + 2 * k_fHeightOneLine, k_fBtnShowHideAnswerWidthCollection, k_fBtnShowHideAnswerHeightCollection);
    //
    NSNumber* value = [[NSNumber alloc] initWithInt:0] ;
    for(int i = 0; i < 4; i++) {
        [mAnswersChosen replaceObjectAtIndex:i withObject:value];
    }
}

- (int) getNumLineOfString: (NSString*) str : (UIFont*) font : (float) width{
    CGSize size = [str sizeWithAttributes:@{NSFontAttributeName : font}];
    return ceil(size.width / width);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger) getButtonAnswerIndex: (UIButton*) button {
    NSInteger index;
    if(button == self.btnAnswerACollection) {
        index = [[NSNumber numberWithInteger:0] integerValue];
    }
    else if (button == self.btnAnswerBCollection) {
        index = [[NSNumber numberWithInteger:1] integerValue];
    }
    else if (button == self.btnAnswerCCollection) {
        index = [[NSNumber numberWithInteger:0] integerValue];
    }
    else if (button == self.btnAnswerCCollection) {
        index = [[NSNumber numberWithInteger:0] integerValue];
    }
    else
        index = [[NSNumber numberWithInteger:0] integerValue];
    return index;
}

- (UIButton*) getButtonAnswerWithIndex: (NSInteger) index {
    UIButton* btn;
    if(index == 0)
        btn = self.btnAnswerACollection;
    if(index == 1)
        btn = self.btnAnswerBCollection;
    if(index == 2)
        btn = self.btnAnswerCCollection;
    if(index == 3)
        btn = self.btnAnswerDCollection;
    return btn;
}

- (IBAction)onTouchUpInsideBtnAnswerACollection:(id)sender {
    NSUInteger indexBtnTapped = [self getButtonAnswerIndex:sender];
    if(([mAnswersChosen objectAtIndex:indexBtnTapped]) == ([[NSNumber alloc] initWithInt:1])) {
        [mAnswersChosen replaceObjectAtIndex:indexBtnTapped withObject:[[NSNumber alloc] initWithInt:0]];
        self.imgViewAnswerACollection.hidden = true;
    }
    else {
        [mAnswersChosen replaceObjectAtIndex:indexBtnTapped withObject:[[NSNumber alloc] initWithInt:1]];
        self.imgViewAnswerACollection.hidden = false;
    }
    
}

- (IBAction)onTouchUpInsideBtnAnswerBCollection:(id)sender {
    NSUInteger indexBtnTapped = [self getButtonAnswerIndex:sender];
    if(([mAnswersChosen objectAtIndex:indexBtnTapped]) == ([[NSNumber alloc] initWithInt:1])) {
        [mAnswersChosen replaceObjectAtIndex:indexBtnTapped withObject:[[NSNumber alloc] initWithInt:0]];
        self.imgViewAnswerBCollection.hidden = true;
    }
    else {
        [mAnswersChosen replaceObjectAtIndex:indexBtnTapped withObject:[[NSNumber alloc] initWithInt:1]];
        self.imgViewAnswerBCollection.hidden = false;
    }

}

- (IBAction)onTouchUpInsideBtnAnswerCCollection:(id)sender {
    NSUInteger indexBtnTapped = [self getButtonAnswerIndex:sender];
    if(([mAnswersChosen objectAtIndex:indexBtnTapped]) == ([[NSNumber alloc] initWithInt:1])) {
        [mAnswersChosen replaceObjectAtIndex:indexBtnTapped withObject:[[NSNumber alloc] initWithInt:0]];
        self.imgViewAnswerCCollection.hidden = true;
    }
    else {
        [mAnswersChosen replaceObjectAtIndex:indexBtnTapped withObject:[[NSNumber alloc] initWithInt:1]];
        self.imgViewAnswerCCollection.hidden = false;
    }

}

- (IBAction)onTouchUpInsideBtnAnswerDCollection:(id)sender {
    NSUInteger indexBtnTapped = [self getButtonAnswerIndex:sender];
    if(([mAnswersChosen objectAtIndex:indexBtnTapped]) == ([[NSNumber alloc] initWithInt:1])) {
        [mAnswersChosen replaceObjectAtIndex:indexBtnTapped withObject:[[NSNumber alloc] initWithInt:0]];
        self.imgViewAnswerDCollection.hidden = true;
    }
    else {
        [mAnswersChosen replaceObjectAtIndex:indexBtnTapped withObject:[[NSNumber alloc] initWithInt:1]];
        self.imgViewAnswerDCollection.hidden = false;
    }

}

- (IBAction)onTouchDownBtnShowHideAnswerCollection:(id)sender {
    if(m_bRightAnswerHidden){//right answer is hidden
        [self.btnShowHideAnswerCollection setBackgroundImage:[UIImage imageNamed:@"btnHideRightAnswerCollection"] forState:UIControlStateNormal];
        m_bRightAnswerHidden = false;
        
        NSMutableArray* rightAnswer = [[mPracticeSession getQuestionCollection] getRightAnswerAtIndex: [mPracticeSession getCurrentIndex]];
        //show right answer
        for(NSNumber* value in rightAnswer) {
            [[self getButtonAnswerWithIndex:[value integerValue]] setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        }
    }
    else{
        [self.btnShowHideAnswerCollection setBackgroundImage:[UIImage imageNamed:@"btnShowRightAnswerCollection"] forState:UIControlStateNormal];
        m_bRightAnswerHidden = true;
        
        NSMutableArray* rightAnswer = [[mPracticeSession getQuestionCollection] getRightAnswerAtIndex: [mPracticeSession getCurrentIndex]];
        //hide right answer
        for(NSNumber* value in rightAnswer) {
            [[self getButtonAnswerWithIndex:[value integerValue]] setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        
    }

}

//SelectQuestion
- (IBAction)onTouchUpInsideBtnSelectQuestionCollection:(id)sender {
    if(self.uiTRACYQuestionBoard.bButtonTouched){
        self.uiTRACYQuestionBoard.hidden = true;
        self.uiTRACYQuestionBoard.bButtonTouched = false;
    }
    else{
        self.uiTRACYQuestionBoard.hidden = false;
        self.uiTRACYQuestionBoard.bButtonTouched = true;
        [self disableControlsOnSelectingQuestion];
    }

}

- (IBAction)onTouchUpInsideBtnSelectQuestionIndexCollection:(id)sender {
    if(self.uiTRACYQuestionBoard.bButtonTouched){
        self.uiTRACYQuestionBoard.hidden = true;
        self.uiTRACYQuestionBoard.bButtonTouched = false;
    }

}

- (IBAction)onTouchDownBtnSelectQuestionIndexCollection:(id)sender {
    if(self.uiTRACYQuestionBoard.bButtonTouched){
        
         [self showQuestionAtIndex: self.uiTRACYQuestionBoard.uintCurrentTouchIndex];
    }
}

//ChooseCollection
- (IBAction)onTouchUpInsideBtnChooseCollection:(id)sender {
    if(self.uiTRACYChooseCollection.bButtonTouched){
        self.uiTRACYChooseCollection.hidden = true;
        self.uiTRACYChooseCollection.bButtonTouched = false;
    }
    else{
        self.uiTRACYChooseCollection.hidden = false;
        self.uiTRACYChooseCollection.bButtonTouched = true;
        [self disableControlsOnSelectingCollection ];
    }
}

- (IBAction)onTouchDownChooseIndexCollection:(id)sender {
    if(self.uiTRACYChooseCollection.bButtonTouched){
        self.uiTRACYChooseCollection.hidden = true;
        [self showQuestionAtIndex: self.uiTRACYChooseCollection.uintCurrentTouchIndex];
    }
}

- (IBAction)onTouchUpInsideChooseIndexCollection:(id)sender {
    if(self.uiTRACYQuestionBoard.bButtonTouched){
        self.uiTRACYQuestionBoard.hidden = true;
        self.uiTRACYQuestionBoard.bButtonTouched = false;
    }
}

//delegate
- (void) didSelect {
    [self enableControlsAfterSelecting];
}

- (void) enableControlsAfterSelecting {
    NSArray *subViews = [self.scrollViewCollection subviews];
    for(UIControl *control in subViews) {
            control.enabled = true;
    }

}

- (void) disableControlsOnSelectingQuestion {
    NSArray *subViews = [self.scrollViewCollection subviews];
    for(UIControl *control in subViews) {
        if(control.tag != k_iTagbtnSelectQuestionCollection && control.tag != k_iTaguiTRACYQuestionBoard) {
            control.enabled = false;
        }
    }
}

- (void) disableControlsOnSelectingCollection {
    NSArray *subViews = [self.scrollViewCollection subviews];
    for(UIControl *control in subViews) {
        if(control.tag != k_iTagbtnSelectCollection && control.tag != k_iTaguiTRACYChooseCollection) {
            control.enabled = false;
        }
    }
}
@end
