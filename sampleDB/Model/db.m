//
//  db.m
//  sampleDB
//
//  Created by Htain Lin Shwe on 23/3/13.
//  Copyright (c) 2013 comquas. All rights reserved.
//

#import "db.h"
#import "FMDatabase.h"

@implementation db

+(NSString*)dbpath
{
    NSString *DOCUMENTS_FOLDER = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    return [DOCUMENTS_FOLDER stringByAppendingPathComponent:@"db.sqlite"];
}

+(BOOL)isCopied
{
    if([[NSFileManager defaultManager] fileExistsAtPath:[db dbpath]])
    {
        return YES;
    }
    return NO;
}

+ (db*)sharedClient {
    static db *_sharedClient = nil;
    
    if (_sharedClient == nil) {
        _sharedClient = [[db alloc] init];
        [db setup];
        _sharedClient.database = [[FMDatabase alloc] initWithPath:[db dbpath]];
        if (![_sharedClient.database open]) {
            NSLog(@"Error");
        }
    }

    return _sharedClient;
}

+(void)setup {
    if(![db isCopied])
    {
        NSString* originalPath = [[NSBundle mainBundle] pathForResource:@"contact" ofType:@"sqlite"];
        
        NSError* error = nil;
        [[NSFileManager defaultManager] copyItemAtPath:originalPath toPath:[db dbpath] error:&error];
        
        if(error)
        {
            NSLog(@"%@",[error localizedDescription]);
        }
    }
    NSLog(@"DB PATH %@",[db dbpath]);
}



@end
