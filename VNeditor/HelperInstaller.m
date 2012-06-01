//
//  HelperInstaller.m
//  VNeditor
//
//  Created by Chris Campbell on 29/05/2012.
//  Copyright (c) 2012 C T Campbell Ltd. All rights reserved.
//

#import "HelperInstaller.h"

@implementation HelperInstaller

- (BOOL)installHelper
{
    // Get authorization
    AuthorizationRef authRef = [self createAuthRef];
    if (authRef == NULL) {
        NSLog(@"Authorization failed");
        return NO;
    }
    
    // Bless Helper
    NSError *error = nil;
    if (![self blessHelperWithLabel:@"com.ctcampbell.VNeditorHelper" withAuthRef:authRef error:&error]) {
        NSLog(@"Failed to bless helper: %@", error);
        return NO;
    }
    
    return YES;
}

- (AuthorizationRef)createAuthRef
{
    AuthorizationRef authRef = NULL;
    AuthorizationItem authItem = { kSMRightBlessPrivilegedHelper, 0, NULL, 0 };
    AuthorizationRights authRights = { 1, &authItem };
    AuthorizationFlags flags = kAuthorizationFlagDefaults | kAuthorizationFlagInteractionAllowed | kAuthorizationFlagPreAuthorize | kAuthorizationFlagExtendRights;
    
    OSStatus status = AuthorizationCreate(&authRights, kAuthorizationEmptyEnvironment, flags, &authRef);
    if (status != errAuthorizationSuccess) {
        NSLog(@"Failed to create AuthorizationRef, return code %i", status);
    }
    
    return authRef;
}

- (BOOL)blessHelperWithLabel:(NSString *)label withAuthRef:(AuthorizationRef)authRef error:(NSError **)error
{
    CFErrorRef err;
    BOOL result = SMJobBless(kSMDomainSystemLaunchd, (__bridge CFStringRef)label, authRef, &err);
    *error = (__bridge NSError *)err;
    
    return result;
}

- (BOOL)needsInstall
{
    NSDictionary*  installedHelperJobData  = (__bridge_transfer NSDictionary*)SMJobCopyDictionary( kSMDomainSystemLaunchd, (CFStringRef)@"com.ctcampbell.VNeditorHelper" );
    
    BOOL needToInstall = YES;
    
    if ( installedHelperJobData )
    {
        //NSLog( @"helperJobData: %@", installedHelperJobData );
        
        NSString*      installedPath          = [[installedHelperJobData objectForKey:@"ProgramArguments"] objectAtIndex:0];
        NSURL*          installedPathURL        = [NSURL fileURLWithPath:installedPath];
        
        NSDictionary*  installedInfoPlist      = (__bridge_transfer NSDictionary*)CFBundleCopyInfoDictionaryForURL( (__bridge_retained CFURLRef)installedPathURL );
        NSString*      installedBundleVersion  = [installedInfoPlist objectForKey:@"CFBundleVersion"];
        NSInteger      installedVersion        = [installedBundleVersion integerValue];
        
        //NSLog( @"installedVersion: %ld", (long)installedVersion );
        
        NSBundle*      appBundle      = [NSBundle mainBundle];
        NSURL*          appBundleURL    = [appBundle bundleURL];
        
        //NSLog( @"appBundleURL: %@", appBundleURL );
        
        NSURL*          currentHelperToolURL    = [appBundleURL URLByAppendingPathComponent:@"Contents/Library/LaunchServices/com.ctcampbell.VNeditorHelper"];
        NSDictionary*  currentInfoPlist        = (__bridge_transfer NSDictionary*)CFBundleCopyInfoDictionaryForURL( (__bridge_retained CFURLRef)currentHelperToolURL );
        NSString*      currentBundleVersion    = [currentInfoPlist objectForKey:@"CFBundleVersion"];
        NSInteger      currentVersion          = [currentBundleVersion integerValue];
        
        //NSLog( @"currentVersion: %ld", (long)currentVersion );
        
        if ( currentVersion == installedVersion )
        {
            needToInstall = NO;
        }
    }

    return needToInstall;
}

@end
