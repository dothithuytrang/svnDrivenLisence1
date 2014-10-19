//
//  TestSession.m
//  In
//
//  Created by TRACY on 2/18/14.
//  Copyright (c) 2014 TRACY. All rights reserved.
//

#import "PracticeSession.h"

@implementation PracticeSession
/*- (id) initWithQuestionCollection : (QuestionCollection*) qC {
    self = [super init];
    if(self) {
        mQuestionCollection = qC;
    }
    return self;
}*/

//collection all
- (id) initAllWithEntity : (NSString*) entityName {
    self =[super init];
    if(self) {
        mQuestionCollection = [[QuestionCollection alloc] initAllWithEntity:entityName];
        mCurrentIndex = 0;
    }
    return self;
}

//collection bode1
- (id) initCollectionWithEntity : (NSString*) entityName: (NSInteger) collectionIndex {
    self =[super init];
    if(self) {
        mQuestionCollection = [[QuestionCollection alloc] initCollectionWithEntity:entityName: collectionIndex];
        mCurrentIndex = 0;
    }
    return self;
}

//history
- (id) initHistoryWithEntity: (NSString*) entityName {
    self =[super init];
    if(self) {
        mQuestionCollection = [[QuestionCollection alloc] initHistoryWithEntity:entityName];
        mCurrentIndex = 0;
    }
    return self;
}



//exam
- (id) initWithEntityAndNumber : (NSString*) entityName : (NSUInteger) numQuestions {
    self =[super init];
    if(self) {
        mQuestionCollection = [[QuestionCollection alloc] initWithEntityAndNumQuestion:entityName:numQuestions];
        mCurrentIndex = 0;
        
    }
    return self;
}

- (QuestionCollection*) getQuestionCollection {
    return mQuestionCollection;
}

- (bool) previousQuestion {
    if(mCurrentIndex > 0)
    {
        mCurrentIndex--;
        return true;
    }
    return false;
}
- (bool) nextQuestion {
    if(mCurrentIndex< ([mQuestionCollection getNumberOfQuestions] - 1))
    {
        mCurrentIndex++;
        return true;
    }
    return false;
}
- (void) setCurrentIndex : (NSInteger) index {
    mCurrentIndex = index;
}
- (NSInteger) getCurrentIndex {
    return mCurrentIndex;
}

- (bool) compareTwoAnswer : (NSMutableArray*) a : (NSMutableArray*) b {
    NSMutableArray* tmpA = [[NSMutableArray alloc] initWithArray:a];
    [tmpA removeObjectsInArray:b];
    NSMutableArray* tmpB = [[NSMutableArray alloc] initWithArray:b];
    [tmpB removeObjectsInArray:a];
    if(([tmpA count] > 0) || ([tmpB count] > 0)){
        return false;
    }
    else {
        return true;
    }
}

- (void) deleteCurrentFromHistory : (NSInteger) currentIndex{
    [mQuestionCollection deleteCurrentFromHistory:currentIndex];
}

@end
