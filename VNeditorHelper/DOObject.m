//
//  DOObject.m
//  VNeditor
//
//  Created by Chris Campbell on 01/06/2012.
//  Copyright (c) 2012 C T Campbell Ltd. All rights reserved.
//

#import "DOObject.h"

@implementation DOObject

- (BOOL)writeFile:(NSString *)inputString
{
    NSLog(@"Writing file to /Library/Preferences/VMware Fusion/networking");
    
    NSString *path = @"/Library/Preferences/VMware Fusion/networking";
    NSError *error;
    
    
    
    BOOL ok = [inputString writeToFile:path atomically:YES
                         encoding:NSASCIIStringEncoding error:&error];
    if (!ok)
    {
        // an error occurred
        NSLog(@"Error writing file at %@\n%@", path, [error localizedFailureReason]);
        
        return FALSE;
    }
    else
    {
        return TRUE;
    }
    
}

- (BOOL)isInstalled
{
    return TRUE;
}

@end
