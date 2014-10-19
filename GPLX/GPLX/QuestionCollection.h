//
//  QuestionCollection.h
//  In
//
//  Created by TRACY on 2/19/14.
//  Copyright (c) 2014 TRACY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TRACYCoreData.h" // work with data core


@interface QuestionCollection : NSObject
{
@protected
    NSUInteger mNumberOfQuestions;
    NSMutableArray *mIdQuestion;
    NSMutableArray *mOriginalQuestions;
    NSMutableArray *mAnswerA;
    NSMutableArray *mAnswerB;
    NSMutableArray *mAnswerC;
    NSMutableArray *mAnswerD;
    NSMutableArray *mRightAnswer;
    NSMutableArray *mHint;
}

- (id) initWithEntityAndNumQuestion : (NSString*) entityName : (NSUInteger) numQuestions;
- (id) initAllWithEntity: (NSString*) entityName;
- (id) initCollectionWithEntity: (NSString*) entityName: (NSInteger) collectionIndex;
- (id) initHistoryWithEntity:(NSString*) entityName;
- (NSMutableArray*) getIdQuestionArray;

- (NSString*) getIdQuestionAtIndex : (NSUInteger) index;
- (NSString*) getQuestionAtIndex : (NSUInteger) index;
- (NSString*) getAnswerAAtIndex : (NSUInteger) index;
- (NSString*) getAnswerBAtIndex : (NSUInteger) index;
- (NSString*) getAnswerCAtIndex : (NSUInteger) index;
- (NSString*) getAnswerDAtIndex : (NSUInteger) index;
- (NSMutableArray*) getRightAnswerAtIndex : (NSUInteger) index;
- (NSString*) getHintAtIndex : (NSUInteger) index;
- (NSUInteger) getNumberOfQuestions;
- (void) deleteCurrentFromHistory:(NSInteger) index;
@end

