//
//  CoreData.h
//  In
//
//  Created by TRACY on 2/19/14.
//  Copyright (c) 2014 TRACY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface TRACYCoreData : NSObject
{
    
}
+ (void) loadDataFromSqliteIntoCoreData : (NSString*) sqliteFileName
                                       : (NSString*) entityName;
+ (void) clearCoreData : (NSString*) entityName;
+ (NSUInteger) getCountRows : (NSString*) entityName;//may be delete
+ (NSString*) getColumnAtIndex : (NSString*) entityName : (NSString*) columnName : (NSUInteger) index;
//+ (void) saveColumnAtIndex : (NSString*) entityName : (bool) value : (NSInteger) index;

@end
