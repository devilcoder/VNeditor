//
//  HelperInstaller.h
//  VNeditor
//
//  Created by Chris Campbell on 29/05/2012.
//  Copyright (c) 2012 C T Campbell Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ServiceManagement/ServiceManagement.h>
#import <Security/Authorization.h>

@interface HelperInstaller : NSObject

- (BOOL)installHelper;
- (AuthorizationRef)createAuthRef;
- (BOOL)blessHelperWithLabel:(NSString *)label withAuthRef:(AuthorizationRef)authRef error:(NSError **)error;
- (BOOL)needsInstall;

@end
