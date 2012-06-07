//
//  BoolValueTransformer.m
//  VNeditor
//
//  Created by Chris Campbell on 31/05/2012.
//  Copyright (c) 2012 C T Campbell Ltd. All rights reserved.
//

#import "BoolValueTransformer.h"

@implementation BoolValueTransformer

+ (Class)transformedValueClass { return [NSNumber class]; }

+ (BOOL)allowsReverseTransformation { return YES; }

- (id)transformedValue:(id)value {
	
	BOOL _boolValue = [value boolValue];
    NSNumber *number = [NSNumber numberWithBool:_boolValue];
	return number;
}

- (id)reverseTransformedValue:(id)value
{
    BOOL _boolValue = [value boolValue];
    NSString *string = _boolValue ? @"yes" : @"no";
    
    return string;
}

@end
