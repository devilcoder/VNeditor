//
//  AppDelegate.h
//  VNeditor
//
//  Created by Chris Campbell on 29/05/2012.
//  Copyright (c) 2012 C T Campbell Ltd. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MainWindowController.h"
#import "HelperInstaller.h"
#import "DOObject.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property(nonatomic, strong) MainWindowController *mainWindowController;

@end