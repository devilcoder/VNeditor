//
//  MainWindowController.m
//  VNeditor
//
//  Created by Chris Campbell on 30/05/2012.
//  Copyright (c) 2012 C T Campbell Ltd. All rights reserved.
//

#import "MainWindowController.h"

@implementation MainWindowController

@synthesize sidebar, controller, commitToolbarItem, networksArray, selectedIndexPaths, fm, hasChanges;

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {

        fm = [[FileManipulation alloc] init];
        networksArray = [fm readVirtualNetworks];
        
        [self registerForKeyPaths];
        
    }
    
    return self;
}

- (void)windowDidLoad
{
    [controller addObserver:self forKeyPath:@"arrangedObjects" options:0 context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self registerForKeyPaths];
    [commitToolbarItem setImage:[NSImage imageNamed:@"Knob Attention.png"]];
}

- (IBAction)commitAction:(id)sender
{
    //dosaveaction    
    if ( [fm writeVirtualNetworks:networksArray] )
    {
        [commitToolbarItem setImage:[NSImage imageNamed:@"Knob Valid Green.png"]];
    }
}

- (void)registerForKeyPaths
{
    for ( id obj in networksArray )
    {
        [obj addObserver:self forKeyPath:@"DHCP" options:0 context:nil];
        [obj addObserver:self forKeyPath:@"DHCP_CFG_HASH" options:0 context:nil];
        [obj addObserver:self forKeyPath:@"NAT" options:0 context:nil];
        [obj addObserver:self forKeyPath:@"VNET" options:0 context:nil];
        [obj addObserver:self forKeyPath:@"VIRTUAL_ADAPTER" options:0 context:nil];
        [obj addObserver:self forKeyPath:@"VIRTUAL_ADAPTER_ADDR" options:0 context:nil];
        [obj addObserver:self forKeyPath:@"HOSTONLY_SUBNET" options:0 context:nil];
        [obj addObserver:self forKeyPath:@"HOSTONLY_NETMASK" options:0 context:nil];
    }
}

@end
