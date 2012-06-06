//
//  MainWindowController.m
//  VNeditor
//
//  Created by Chris Campbell on 30/05/2012.
//  Copyright (c) 2012 C T Campbell Ltd. All rights reserved.
//

#import "MainWindowController.h"
#import "FileManipulation.h"

@interface MainWindowController ()

@property IBOutlet NSOutlineView *sidebar;
@property IBOutlet NSArrayController *controller;
@property IBOutlet NSToolbarItem *commitToolbarItem;

@property NSMutableArray *networksArray;
@property NSMutableArray *selectedIndexPaths;
@property FileManipulation *fm;
@property BOOL hasChanges;

@end

@implementation MainWindowController
@synthesize sidebar, controller, commitToolbarItem, networksArray, selectedIndexPaths, fm, hasChanges;

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {

        fm = [[FileManipulation alloc] init];
        networksArray = [fm readVirtualNetworks];
        
        for ( id obj in networksArray )
        {
            for( NSString *aKey in obj )
            {
                [obj addObserver:self forKeyPath:aKey options:0 context:nil];
            }
        }
        
        //NSMutableArray *vmsArray = [[NSMutableArray alloc] init];
        
        /*dataArray = [NSMutableArray arrayWithObjects:
                     [NSMutableDictionary dictionaryWithObjectsAndKeys:
                      @"VIRTUAL NETWORKS", @"title",
                      networksArray, @"children",
                      [NSNumber numberWithBool:YES], @"header",
                      nil],
                     [NSMutableDictionary dictionaryWithObjectsAndKeys:
                      @"VIRTUAL MACHINES", @"title",
                      vmsArray, @"children",
                      [NSNumber numberWithBool:YES], @"header",
                      nil],
                     nil];*/
    }
    
    return self;
}

- (void)windowDidLoad
{
   // NSParameterAssert(sidebar != nil);
   // sidebar.floatsGroupRows = NO;
   // [sidebar expandItem:nil expandChildren:YES];
   // NSUInteger indexArr[] = {0,0};
   // NSIndexPath *myIP = [NSIndexPath indexPathWithIndexes:indexArr length:2];
   // [controller setSelectionIndexPath:myIP];
    [controller addObserver:self forKeyPath:@"arrangedObjects" options:0 context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"changes!");
    [self setHasChanges:TRUE];
    [commitToolbarItem setImage:[NSImage imageNamed:@"Knob Attention.png"]];
}

- (NSView *)outlineView:(NSOutlineView *)outlineView
      viewForTableColumn:(NSTableColumn *)tableColumn item:(id)item
{
    BOOL isHeader = [[[item representedObject] objectForKey:@"header"] boolValue];
    return [outlineView makeViewWithIdentifier:(isHeader ? @"HeaderCell" : @"DataCell")
                                         owner:self];
}

- (BOOL)outlineView:(NSOutlineView *)outlineView isGroupItem:(id)item
{
    return [[[item representedObject] objectForKey:@"header"] boolValue];
}

- (BOOL)outlineView:(NSOutlineView *)outlineView shouldSelectItem:(id)item
{
    return ![[[item representedObject] objectForKey:@"header"] boolValue];
}

- (IBAction)commitAction:(id)sender
{
    //dosaveaction
    if ( [fm writeVirtualNetworks:networksArray] )
    {
        [commitToolbarItem setImage:[NSImage imageNamed:@"Knob Valid Green.png"]];
    }
}

@end
