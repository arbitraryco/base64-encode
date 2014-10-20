//
//  B64EncoderService.m
//  Base64 Encode
//
//  Created by Jamie Kosoy on 10/19/14.
//  Copyright (c) 2014 Arbitrary. All rights reserved.
//

#import "B64EncoderService.h"

@interface B64EncoderService()
    - (void) beep;
@end

@implementation B64EncoderService

+ (B64EncoderService *) service {
    return [[B64EncoderService alloc] init];
}

#pragma mark

-(id)init {
    self = [super init];

    if(self) {
        NSUpdateDynamicServices();
    }
    
    return self;
}

-(void)encodeFile:(NSPasteboard *)pboard userData: (NSString *)userData error:(NSString **)errorMessagePtr {
    NSLog(@"Encode!");
    
    if (![[pboard types] containsObject:NSFilenamesPboardType] ) {
        *errorMessagePtr = NSLocalizedString(@"Pleaes use finder for this service.", nil);
        return;
    }
    
    NSArray *filenames = [pboard propertyListForType:NSFilenamesPboardType];
    
    if(filenames.count == 0) {
        *errorMessagePtr = NSLocalizedString(@"Something is wrong with the file you selected.", nil);
        return;
    }
    
    NSString *filePath = filenames[0];
    
//    GEMagicResult *mimeType = [GEMagicKit magicForFileAtPath:filePath];
    
    NSLog(@"%@", filePath);
//    NSLog(@"%@", mimeType);
    
    [self beep];    
}

- (void)beep {
    NSBeep();
    
    
    return;
    
    AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle bundleWithIdentifier:@"com.apple.UIKit"] pathForResource:@"Tock" ofType:@"aiff"]] error:NULL];
    [audioPlayer play];
}


@end
