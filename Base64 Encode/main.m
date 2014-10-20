//
//  main.m
//  Base64 Encode
//
//  Created by Jamie Kosoy on 10/19/14.
//  Copyright (c) 2014 Arbitrary. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "B64EncoderService.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool
    {
        B64EncoderService *service = [B64EncoderService service];
        NSRegisterServicesProvider(service, @"B64Encoder");

        [[NSRunLoop currentRunLoop] run];
    }
    
    return 0;
}
