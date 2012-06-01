//
//  MaskFormatter.m
//  Virtual Network Editor
//
//  Created by Chris Campbell on 10/12/2011.
//  Copyright (c) 2012 C T Campbell Ltd. All rights reserved.
//

#import "MaskFormatter.h"

@implementation MaskFormatter

- (NSString *)stringForObjectValue:(id)string
{
    return(string);
}

- (BOOL)getObjectValue:(id *)obj forString:(NSString *)string
	  errorDescription:(NSString  **)error
{
    NSString *regex = @"(|^(([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\.){3}([01]?\\d\\d?|25[0-5]|2[0-4]\\d)$)";
    
    NSPredicate *regextest = [NSPredicate
                              predicateWithFormat:@"SELF MATCHES %@", regex];
    
    if ([regextest evaluateWithObject:string] == YES) {
        *obj = string;
        return(YES);
    } else {
        return(NO);
    }
}


- (BOOL)isPartialStringValid:(NSString *)partialString newEditingString:(NSString **)newString errorDescription:(NSString **)error
{
	NSRange foundRange;
	
	NSCharacterSet *disallowedCharacters = [[NSCharacterSet
                                             characterSetWithCharactersInString:@"0123456789."] invertedSet];
	foundRange = [partialString rangeOfCharacterFromSet:disallowedCharacters];
	if(foundRange.location != NSNotFound)
	{
        NSBeep();
        return(NO);
	}
    return(YES);
}

@end