//
//  QuestionCollection.m
//  In
//
//  Created by TRACY on 2/19/14.
//  Copyright (c) 2014 TRACY. All rights reserved.
//

#import "QuestionCollection.h"


@implementation QuestionCollection

//no use now
- (bool) isRepeated : (NSMutableArray*) array : (NSUInteger) index
{
    bool returnValue = false;
    
    return returnValue;
}

//private
- (void) initArray {
    mOriginalQuestions = [[NSMutableArray alloc] init];
    mIdQuestion = [[NSMutableArray alloc] init];
    mAnswerA = [[NSMutableArray alloc] init];
    mAnswerA = [[NSMutableArray alloc] init];
    mAnswerB = [[NSMutableArray alloc] init];
    mAnswerC = [[NSMutableArray alloc] init];
    mAnswerD = [[NSMutableArray alloc] init];
    mRightAnswer  = [[NSMutableArray alloc] init];
    mHint  = [[NSMutableArray alloc] init];
}

//private
//embroil answer of question
- (void) embroilQuestion
{
    for( int i = 0 ; i < mNumberOfQuestions ; i++ )
    {
        NSMutableArray* answers = [[NSMutableArray alloc] init];
        NSMutableArray* rightAnswers = [[NSMutableArray alloc] init];
        [answers addObject:[mAnswerA objectAtIndex:i]];
        [answers addObject:[mAnswerB objectAtIndex:i]];
        [answers addObject:[mAnswerC objectAtIndex:i]];
        [answers addObject:[mAnswerD objectAtIndex:i]];
        for( int j = 0 ; j < 4 ; j++ )
        {
            
            int indexChanged = arc4random_uniform(4);
            [answers exchangeObjectAtIndex:j withObjectAtIndex:indexChanged];
            
        }
        for( int j = 0 ; j < 4 ; j++ )
        {
            NSString* answ = [answers objectAtIndex:j];
            if([answ rangeOfString:@"rr"].location != NSNotFound) {
                [rightAnswers addObject:[NSNumber numberWithInteger:j]];
            }
            
        }
        [mRightAnswer addObject: rightAnswers];
        [mAnswerA replaceObjectAtIndex:i withObject:[answers objectAtIndex:0]];
        [mAnswerB replaceObjectAtIndex:i withObject:[answers objectAtIndex:1]];
        [mAnswerC replaceObjectAtIndex:i withObject:[answers objectAtIndex:2]];
        [mAnswerD replaceObjectAtIndex:i withObject:[answers objectAtIndex:3]];
    }
    
}

//---- collection all-----------
//get all question ---- collection all-----------
- (void) getAllQuestionFromDatabase : (NSString*) entityName {
    //get number of rows in core data
    mNumberOfQuestions = [TRACYCoreData getCountRows: entityName];
    for( int i = 1 ; i <= mNumberOfQuestions ; i++ )
    {
        NSString* questionAndAnswer = [TRACYCoreData getColumnAtIndex:entityName : @"id" : i];
        [mIdQuestion addObject:questionAndAnswer];
        questionAndAnswer = [TRACYCoreData getColumnAtIndex:entityName : @"question" : i];
        [mOriginalQuestions addObject:questionAndAnswer];
        questionAndAnswer = [TRACYCoreData getColumnAtIndex:entityName : @"answerA" : i];
        [mAnswerA addObject:questionAndAnswer];
        questionAndAnswer = [TRACYCoreData getColumnAtIndex:entityName : @"answerB" : i];
        [mAnswerB addObject:questionAndAnswer];
        questionAndAnswer = [TRACYCoreData getColumnAtIndex:entityName : @"answerC" : i];
        [mAnswerC addObject:questionAndAnswer];
        questionAndAnswer = [TRACYCoreData getColumnAtIndex:entityName : @"answerD" : i];
        [mAnswerD addObject:questionAndAnswer];
        
        
        //todo no use hint more
        questionAndAnswer = [TRACYCoreData getColumnAtIndex:entityName : @"hint" : i];
        [mHint addObject:questionAndAnswer];
    }
}
- (id) initAllWithEntity: (NSString*) entityName {
    self = [super init];
    if(self)
    {
        [self initArray];
        [self getAllQuestionFromDatabase : entityName];
        [self embroilQuestion];
    }
    return self;
}

//get question of bode---- collection bode-----------
- (id) initCollectionWithEntity: (NSString*) entityName: (NSInteger) collectionIndex {
    self = [super init];
    if(self)
    {
        [self initArray];
        [self getCollectionWithEntity: entityName: collectionIndex];
        [self embroilQuestion];
    }
    return self;
}

- (void) getCollectionWithEntity: (NSString*) entityName: (NSInteger) collectionIndex {
    mNumberOfQuestions = [TRACYCoreData getCountRows: entityName];
    for( int i = 1 ; i <= mNumberOfQuestions ; i++ )
    {
        NSString* questionAndAnswer = [TRACYCoreData getColumnAtIndex:entityName : @"collectionIndex" : i];
        NSNumber *value = [[NSNumber alloc] initWithInt:[questionAndAnswer intValue]];
        if(value == collectionIndex) {
            [mIdQuestion addObject:questionAndAnswer];
            questionAndAnswer = [TRACYCoreData getColumnAtIndex:entityName : @"id" : i];
            [mIdQuestion addObject:questionAndAnswer];
            questionAndAnswer = [TRACYCoreData getColumnAtIndex:entityName : @"question" : i];
            [mOriginalQuestions addObject:questionAndAnswer];
            questionAndAnswer = [TRACYCoreData getColumnAtIndex:entityName : @"answerA" : i];
            [mAnswerA addObject:questionAndAnswer];
            questionAndAnswer = [TRACYCoreData getColumnAtIndex:entityName : @"answerB" : i];
            [mAnswerB addObject:questionAndAnswer];
            questionAndAnswer = [TRACYCoreData getColumnAtIndex:entityName : @"answerC" : i];
            [mAnswerC addObject:questionAndAnswer];
            questionAndAnswer = [TRACYCoreData getColumnAtIndex:entityName : @"answerD" : i];
            [mAnswerD addObject:questionAndAnswer];
            questionAndAnswer = [TRACYCoreData getColumnAtIndex:entityName : @"hint" : i];
            [mHint addObject:questionAndAnswer];
        }
    }

}

//get question in history ---------------
- (void) getHistoryWithEntity : (NSString*) entityName {
    //get number of rows in core data
    mNumberOfQuestions = [TRACYCoreData getCountRows: entityName];
    for( int i = 1 ; i <= mNumberOfQuestions ; i++ )
    {
        NSString* questionAndAnswer = [TRACYCoreData getColumnAtIndex:entityName : @"history" : i];
        NSNumber *value = [[NSNumber alloc] initWithInt:[questionAndAnswer intValue]];
        bool isHistory = [value boolValue];
        if(isHistory) {
            [mIdQuestion addObject:questionAndAnswer];
            questionAndAnswer = [TRACYCoreData getColumnAtIndex:entityName : @"id" : i];
            [mIdQuestion addObject:questionAndAnswer];
            questionAndAnswer = [TRACYCoreData getColumnAtIndex:entityName : @"question" : i];
            [mOriginalQuestions addObject:questionAndAnswer];
            questionAndAnswer = [TRACYCoreData getColumnAtIndex:entityName : @"answerA" : i];
            [mAnswerA addObject:questionAndAnswer];
            questionAndAnswer = [TRACYCoreData getColumnAtIndex:entityName : @"answerB" : i];
            [mAnswerB addObject:questionAndAnswer];
            questionAndAnswer = [TRACYCoreData getColumnAtIndex:entityName : @"answerC" : i];
            [mAnswerC addObject:questionAndAnswer];
            questionAndAnswer = [TRACYCoreData getColumnAtIndex:entityName : @"answerD" : i];
            [mAnswerD addObject:questionAndAnswer];
            questionAndAnswer = [TRACYCoreData getColumnAtIndex:entityName : @"hint" : i];
            [mHint addObject:questionAndAnswer];
        }
    }
}
- (id) initHistoryWithEntity:(NSString*) entityName {
    self = [super init];
    if(self)
    {
        [self initArray];
        [self getHistoryWithEntity : entityName];
        [self embroilQuestion];
    }
    return self;
}

//---- exam view -----------
//get random question --------------
- (void) getRandomQuestionFromDatabase :(NSString*) entityName
{
    NSMutableArray* indexArray = [[NSMutableArray alloc] init];
    //get number of rows in core data
    NSUInteger numRows = [TRACYCoreData getCountRows: entityName];
    for( int i = 0 ; i < mNumberOfQuestions ; i++ )
    {
        NSNumber *indexNSNumber = [[NSNumber alloc] initWithInt:(arc4random_uniform(numRows) + 1)];
        if( !([indexArray containsObject:indexNSNumber]) || (i == 1) )
        {
            [indexArray addObject:indexNSNumber];
            NSUInteger index = [indexNSNumber unsignedIntegerValue];
            NSString* questionAndAnswer = [TRACYCoreData getColumnAtIndex:entityName : @"id" : index];
            [mIdQuestion addObject:questionAndAnswer];
            questionAndAnswer = [TRACYCoreData getColumnAtIndex:entityName : @"question" : index];
            [mOriginalQuestions addObject:questionAndAnswer];
            questionAndAnswer = [TRACYCoreData getColumnAtIndex:entityName : @"answerA" : index];
            [mAnswerA addObject:questionAndAnswer];
            questionAndAnswer = [TRACYCoreData getColumnAtIndex:entityName : @"answerB" : index];
            [mAnswerB addObject:questionAndAnswer];
            questionAndAnswer = [TRACYCoreData getColumnAtIndex:entityName : @"answerC" : index];
            [mAnswerC addObject:questionAndAnswer];
            questionAndAnswer = [TRACYCoreData getColumnAtIndex:entityName : @"answerD" : index];
            [mAnswerD addObject:questionAndAnswer];
            questionAndAnswer = [TRACYCoreData getColumnAtIndex:entityName : @"hint" : index];
            [mHint addObject:questionAndAnswer];
        }
        else
        {
            i--;
        }
        
    }
    
}
/* incase only 1 answer and first is right
 - (void) embroilQuestion
 {
 for( int i = 0 ; i < mNumberOfQuestions ; i++ )
 {
 NSMutableArray* answers = [[NSMutableArray alloc] init];
 [answers addObject:[mAnswerA objectAtIndex:i]];
 [answers addObject:[mAnswerB objectAtIndex:i]];
 [answers addObject:[mAnswerC objectAtIndex:i]];
 [answers addObject:[mAnswerD objectAtIndex:i]];
 int currentRightAnswer = 0;
 for( int j = 0 ; j < 4 ; j++ )
 {
 
 int indexChanged = arc4random_uniform(4);
 [answers exchangeObjectAtIndex:j withObjectAtIndex:indexChanged];
 if(indexChanged == currentRightAnswer)
 {
 currentRightAnswer = j;
 }
 else if(j == currentRightAnswer)
 {
 currentRightAnswer = indexChanged;
 }
 
 }//red green black blue
 [mRightAnswer addObject:[[NSNumber alloc] initWithInt:currentRightAnswer]] ;
 [mAnswerA replaceObjectAtIndex:i withObject:[answers objectAtIndex:0]];
 [mAnswerB replaceObjectAtIndex:i withObject:[answers objectAtIndex:1]];
 [mAnswerC replaceObjectAtIndex:i withObject:[answers objectAtIndex:2]];
 [mAnswerD replaceObjectAtIndex:i withObject:[answers objectAtIndex:3]];
 }
 
 }*/
- (id) initWithEntityAndNumQuestion : (NSString*) entityName : (NSUInteger) numQuestions
{
    self = [super init];
    if(self)
    {
        [self initArray];
        mNumberOfQuestions = numQuestions;
        [self getRandomQuestionFromDatabase : entityName];
        [self embroilQuestion];
    }
    return self;
}


///
- (NSMutableArray*) getIdQuestionArray {
    return mIdQuestion;
}
- (NSString*) getIdQuestionAtIndex : (NSUInteger) index {
    return  [mIdQuestion objectAtIndex:index];
}
- (NSString*) getQuestionAtIndex : (NSUInteger) index
{
    return [mOriginalQuestions objectAtIndex:index];
}
- (NSString*) getAnswerAAtIndex : (NSUInteger) index
{
    return [mAnswerA objectAtIndex:index];
}
- (NSString*) getAnswerBAtIndex : (NSUInteger) index
{
    return [mAnswerB objectAtIndex:index];
}
- (NSString*) getAnswerCAtIndex : (NSUInteger) index
{
    return [mAnswerC objectAtIndex:index];
}
- (NSString*) getAnswerDAtIndex : (NSUInteger) index
{
    return [mAnswerD objectAtIndex:index];
}
- (NSString*) getHintAtIndex  : (NSUInteger) index
{
    return [mHint objectAtIndex:index];
}
- (NSMutableArray*) getRightAnswerAtIndex : (NSUInteger) index
{
    NSMutableArray* rightAnswer = [mRightAnswer objectAtIndex:index];
    return rightAnswer;
}
- (NSUInteger) getNumberOfQuestions {
    return mNumberOfQuestions;
}

- (void) deleteCurrentFromHistory:(NSInteger) index {
    //[TRACYCoreData clearCoreData:<#(NSString *)#>];
    
    
}
@end

