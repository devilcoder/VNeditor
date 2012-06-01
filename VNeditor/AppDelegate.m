//
//  AppDelegate.m
//  VNeditor
//
//  Created by Chris Campbell on 29/05/2012.
//  Copyright (c) 2012 C T Campbell Ltd. All rights reserved.
//

#import "AppDelegate.h"


@implementation AppDelegate

@synthesize mainWindowController;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    HelperInstaller *helper = [HelperInstaller new];
    
    if ( [helper needsInstall] )
    {
        [helper installHelper];
    }
    
    mainWindowController = [[MainWindowController alloc] initWithWindowNibName:@"MainWindow"];
    [mainWindowController showWindow:self];
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)theApplication
{
    return YES;
}

@end
