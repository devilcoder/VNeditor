//
//  FileManipulation.h
//  VNeditor
//
//  Created by Chris Campbell on 29/05/2012.
//  Copyright (c) 2012 C T Campbell Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDFileReader.h"
#import "DOObject.h"

@interface FileManipulation : NSObject

@property NSString *fileExtras;

- (NSMutableArray *)readVirtualNetworks;
- (BOOL)writeVirtualNetworks:(NSMutableArray *)array;

@end