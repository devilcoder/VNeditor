//
//  MainWindowController.h
//  VNeditor
//
//  Created by Chris Campbell on 30/05/2012.
//  Copyright (c) 2012 C T Campbell Ltd. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "FileManipulation.h"
#import "MainWindowController.h"

@interface MainWindowController : NSWindowController <NSOutlineViewDelegate>

@property IBOutlet NSOutlineView *sidebar;
@property IBOutlet NSArrayController *controller;
@property IBOutlet NSToolbarItem *commitToolbarItem;
@property IBOutlet NSToolbarItem *refreshToolbarItem;

@property NSMutableArray *networksArray;
@property NSMutableArray *selectedIndexPaths;
@property FileManipulation *fm;
@property BOOL hasChanges;

- (IBAction)commitAction:(id)sender;
- (IBAction)refreshAction:(id)sender;
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context;

@end
