//
//  CoreData.m
//  In
//
//  Created by TRACY on 2/19/14.
//  Copyright (c) 2014 TRACY. All rights reserved.
//

#import "TRACYCoreData.h"

@implementation TRACYCoreData
+ (void) loadDataFromSqliteIntoCoreData : (NSString*) sqliteFileName
                                      : (NSString*) entityName
{
    sqlite3 *contactDB;
    sqlite3_stmt * statement;
    NSString        *databasePath;
    // Build the path to the database file
    databasePath = [[NSBundle mainBundle] pathForResource:sqliteFileName ofType:@"sqlite"];
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        NSString  *query = @"SELECT * FROM QuestionList";
        if (sqlite3_prepare_v2(contactDB, [query UTF8String], -1, &statement, nil) != SQLITE_OK)
        {
            NSLog(@"problem reading data");
        }
        else
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                //read id
                NSNumber *idQuestion = [NSNumber numberWithInt:
                                        (int) sqlite3_column_int(
                                                                 statement, 0)];
                //set value id
                id delegateContext = [[UIApplication sharedApplication] delegate];
                NSManagedObjectContext *context = [delegateContext managedObjectContext];
                NSManagedObject *model = [NSEntityDescription
                                          insertNewObjectForEntityForName:entityName
                                          inManagedObjectContext:context];
                //
                [model setValue:idQuestion forKey:@"id"];
                
                //read question
                NSString *questionAndAnswer = [[NSString alloc]
                                      initWithUTF8String:
                                      (const char *) sqlite3_column_text(
                                                                         statement, 1)];
                //set value question
                [model setValue:questionAndAnswer forKey:@"question"];
                //read answerA
                questionAndAnswer = [[NSString alloc]
                                      initWithUTF8String:
                                      (const char *) sqlite3_column_text(
                                                                         statement, 2)];
                //set value  answerA
                [model setValue:questionAndAnswer forKey:@"answerA"];
                //read  answerB
                questionAndAnswer = [[NSString alloc]
                                     initWithUTF8String:
                                     (const char *) sqlite3_column_text(
                                                                        statement, 3)];
                //set value  answerB
                [model setValue:questionAndAnswer forKey:@"answerB"];
                //read  answerC
                questionAndAnswer = [[NSString alloc]
                                     initWithUTF8String:
                                     (const char *) sqlite3_column_text(
                                                                        statement, 4)];
                //set value  answerC
                [model setValue:questionAndAnswer forKey:@"answerC"];
                //read  answerD
                questionAndAnswer = [[NSString alloc]
                                     initWithUTF8String:
                                     (const char *) sqlite3_column_text(
                                                                        statement, 5)];
                //set value  answerD
                [model setValue:questionAndAnswer forKey:@"answerD"];
                 //read  hint
                questionAndAnswer = [[NSString alloc]
                                     initWithUTF8String:
                                     (const char *) sqlite3_column_text(
                                                                        statement, 6)];

                //[model setValue:questionAndAnswer forKey:@"collectionIndex"];
                //we down't use hint more, leave it there
                //set value  hint
                [model setValue:questionAndAnswer forKey:@"collection"];
                [model setValue:questionAndAnswer forKey:@"hint"];
                [model setValue:[[NSNumber alloc] initWithBool:true] forKey:@"history"];
                //////////
                
                NSError *error;
                if (![context save:&error])//save to core data
                {
                    NSLog(@"Couldn't save: %@", [error localizedDescription]);
                }
                
            }
        }
        
    }
}

+ (void) clearCoreData : (NSString*) entityName
{
    NSError *error;
    id delegateContext = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [delegateContext managedObjectContext];
    NSFetchRequest *fetchRequest =
    [NSFetchRequest fetchRequestWithEntityName:entityName];
    fetchRequest.includesPropertyValues = NO;
    fetchRequest.includesSubentities = NO;
    NSArray *items = [context executeFetchRequest:fetchRequest error:&error];
    
    for (NSManagedObject *managedObject in items) {
        [context deleteObject:managedObject];
        NSLog(@"Deleted %@", entityName);
    }
    if (![context save:&error])//save to core data
    {
        NSLog(@"Couldn't save: %@", [error localizedDescription]);
    }
}

+ (NSUInteger) getCountRows : (NSString*) entityName //may be deleted
{
    NSUInteger countRows = 0;
    NSError *error;
    //(NSUInteger)countForFetchRequest:(NSFetchRequest *)request error:(NSError **)error
    id delegateContext = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext * context = [delegateContext managedObjectContext];
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:entityName];
    fetchRequest.includesPropertyValues = NO;
    fetchRequest.includesSubentities = NO;
    countRows = [context countForFetchRequest:fetchRequest error:&error];
    return countRows;
}

+ (NSString*) getColumnAtIndex : (NSString*) entityName  : (NSString*) columnName : (NSUInteger) index
{
    NSString* returnValue = @"";
    NSError *error;
    id delegateContext = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [delegateContext managedObjectContext];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(id == %d)", index];
    NSFetchRequest *fetchRequest =
    [NSFetchRequest fetchRequestWithEntityName:entityName];
    [fetchRequest setPredicate:predicate];
    //fetchRequest.includesPropertyValues = NO;
    //fetchRequest.includesSubentities = NO;
    NSArray *items = [context executeFetchRequest:fetchRequest error:&error];
    //get value from
    /*NSManagedObject *model = [NSEntityDescription
                              insertNewObjectForEntityForName:entityName
                              inManagedObjectContext:context];*/
    for (NSManagedObject *model in items)
    {
        returnValue  = [NSString stringWithFormat:@"%@", [model valueForKey:columnName]];
    }
    return returnValue;
}
/*+ (void) saveColumnAtIndex : (NSString*) entityName : (bool) value : (NSInteger) index {
    id delegateContext = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [delegateContext managedObjectContext];
    NSManagedObject *model = [NSEntityDescription
                              insertNewObjectForEntityForName:entityName
                              inManagedObjectContext:context];
    //
    [model setValue:[[NSNumber alloc] initWithBool:value] forKey:@"history"];
    NSError *error;
    if (![context save:&error])//save to core data
    {
        NSLog(@"Couldn't save: %@", [error localizedDescription]);
    }


}*/
+ (void) clearCoreData1 : (NSString*) entityName
{
    int i = 7;
    i += 8;
}
+ (void) aa
{
    
}
@end
