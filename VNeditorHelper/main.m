//
//  main.m
//  VNeditorHelper
//
//  Created by Chris Campbell on 29/05/2012.
//  Copyright (c) 2012 C T Campbell Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <launch.h>
#import <syslog.h>
#import "DOObject.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        syslog(LOG_NOTICE, "ElevatorDOHelper launched (uid: %d, euid: %d, pid: %d)", getuid(), geteuid(), getpid());
        
        launch_data_t req = launch_data_new_string(LAUNCH_KEY_CHECKIN);
        launch_data_t resp = launch_msg(req);
        launch_data_t machData = launch_data_dict_lookup(resp, LAUNCH_JOBKEY_MACHSERVICES);
        launch_data_t machPortData = launch_data_dict_lookup(machData, "com.ctcampbell.VNeditorHelper.mach");
        
        mach_port_t machPort = launch_data_get_machport(machPortData);
        launch_data_free(req);
        launch_data_free(resp);
        
        NSMachPort *receivePort = [[NSMachPort alloc] initWithMachPort:machPort];
        NSConnection *connection = [NSConnection connectionWithReceivePort:receivePort sendPort:nil];
        
        DOObject *obj = [DOObject new];
        [connection setRootObject:obj];
        
        [[NSRunLoop currentRunLoop] run];
        
    }
    
    return 0;
}

