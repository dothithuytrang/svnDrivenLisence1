//
//  TestSession.h
//  In
//
//  Created by TRACY on 2/18/14.
//  Copyright (c) 2014 TRACY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QuestionCollection.h"

@interface PracticeSession : NSObject
{
    @protected
    QuestionCollection* mQuestionCollection;
    NSInteger mCurrentIndex;
    NSMutableArray* mResultAnswer;
}
//- (id) initWithQuestionCollection : (QuestionCollection*) qC;
- (id) initWithEntityAndNumber : (NSString*) entityName : (NSUInteger) numQuestions;
- (id) initAllWithEntity : (NSString*) entityName;
- (id) initCollectionWithEntity : (NSString*) entityName: (NSInteger) collectionIndex;
- (id) initHistory: (NSString*) entityName;
- (QuestionCollection*) getQuestionCollection;
- (bool) previousQuestion;
- (bool) nextQuestion;
- (void) setCurrentIndex : (NSInteger) index;
- (NSInteger) getCurrentIndex;
- (bool) compareTwoAnswer : (NSMutableArray*) a : (NSMutableArray*) b;
- (void) deleteCurrentFromHistory : (NSInteger) currentIndex;
@end
