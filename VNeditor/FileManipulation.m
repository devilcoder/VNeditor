//
//  FileManipulation.m
//  VNeditor
//
//  Created by Chris Campbell on 29/05/2012.
//  Copyright (c) 2012 C T Campbell Ltd. All rights reserved.
//

#import "FileManipulation.h"

@implementation FileManipulation

@synthesize fileExtras;

- (NSMutableArray *)readVirtualNetworks
{
    NSMutableDictionary *dictOfVMnetDicts = [[NSMutableDictionary alloc] init];
    
    //initialise fileExtras string
    [self setFileExtras:@""];
    
    //grab file contents and read in lines
    DDFileReader * reader = [[DDFileReader alloc] initWithFilePath:@"/Library/Preferences/VMware Fusion/networking"];
    
    //declare vnet int and nil line
    int vnet = 0;
    NSString * line = nil;
    
    while ( (line = [reader readLine]) )
    {
        //look for "answer" to indicate a VMnet info line
        if ( [line rangeOfString:@"answer"].location != NSNotFound )
        {
            //remove first 12 characters from line and scan in vnet number
            NSString *scanString = [line substringFromIndex:12];
            NSScanner *scanner = [NSScanner scannerWithString:scanString];

            [scanner scanInt:&vnet];
            NSString *vnetID = [NSString stringWithFormat:@"%i", vnet];
            
            //get rest of line, remove first underscore and split remainder at the space
            NSString *valuesString = [[scanner string] substringFromIndex:[scanner scanLocation] + 1];
            NSArray *values = [valuesString componentsSeparatedByString:@" "];
            
            //create dictionary if it doesn't exist
            if (![dictOfVMnetDicts objectForKey:vnetID])
            {
                NSMutableDictionary * dictOfVMnetParams = [[NSMutableDictionary alloc] init];
                [dictOfVMnetDicts setObject:dictOfVMnetParams forKey:vnetID];
                [[dictOfVMnetDicts objectForKey:vnetID] setValue:vnetID forKey:@"VNET"];
            }
            
            [[dictOfVMnetDicts objectForKey:vnetID] setValue:[[values objectAtIndex:1] substringToIndex:[[values objectAtIndex:1] length] - 1] forKey:[values objectAtIndex:0]];
        }
        else
        {
            //save extras
            [self setFileExtras:[fileExtras stringByAppendingString:line]];
        }
        
    }
    
    //convert, sort and return array
    NSMutableArray *returnArray = [NSMutableArray arrayWithArray:[dictOfVMnetDicts allValues]];
    
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES];
    [returnArray sortUsingDescriptors:[NSArray arrayWithObjects:descriptor,nil]];
    
    return returnArray;
    
}

- (BOOL)writeVirtualNetworks:(NSMutableArray *)array
{
    //create file contents
    NSString *outputString = fileExtras;
    
    for ( id obj in array )
    {
        for( NSString *aKey in obj )
        {
            if ( [aKey compare:@"VNET"] )
            {
                outputString = [outputString stringByAppendingFormat:@"answer VNET_%@_%@ %@\n", [obj objectForKey:@"VNET"], aKey, [obj objectForKey:aKey]];
            }
            
        }

    }
    
    //write file
    
    // Connect to DO
    [self showMessage:@"Connecting to DO"];
    NSConnection *c = [NSConnection connectionWithRegisteredName:@"com.ctcampbell.VNeditorHelper.mach" host:nil]; 
    DOObject *proxy = (DOObject *)[c rootProxy];
    
    // Get name from DO
    [proxy writeFile:outputString];
    
    //return BOOL
    return TRUE;
    
}

- (void)showMessage:(NSString *)msg
{
    //NSLog(@"%@", msg);
}

@end