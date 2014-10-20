//
//  B64EncoderService.m
//  Base64 Encode
//
//  Created by Jamie Kosoy on 10/19/14.
//  Copyright (c) 2014 Arbitrary. All rights reserved.
//

#import "B64EncoderService.h"

@interface B64EncoderService()
    - (void)beep;
    - (NSString *)guessMIMETypeFromFile:(NSString *)file;
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
    NSString *mimeType = [self guessMIMETypeFromFile:filePath];
    
    NSLog(@"%@", filePath);
    NSLog(@"%@", mimeType);
    
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
    NSData *base64FileData = [fileData base64EncodedDataWithOptions:0];
    NSString *base64FileDataString = [NSString stringWithUTF8String:base64FileData.bytes];

    NSString *webReadyString = [NSString stringWithFormat:@"data:%@;base64,%@", mimeType, base64FileDataString];

    // paste back to the clipboard
    NSPasteboard *generalPasteboard = [NSPasteboard generalPasteboard];
    [generalPasteboard declareTypes:@[NSStringPboardType] owner:nil];
    [generalPasteboard setString:webReadyString forType:NSStringPboardType];

    [self beep];
}

- (void)beep {
    NSBeep();

//    TO DO: custom sound
//    AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle bundleWithIdentifier:@"com.apple.UIKit"] pathForResource:@"Tock" ofType:@"aiff"]] error:NULL];
//    [audioPlayer play];

    return;
}

- (NSString *)guessMIMETypeFromFile: (NSString *)fileName {
    // Borrowed from http://stackoverflow.com/questions/2439020/wheres-the-iphone-mime-type-database
    CFStringRef UTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (__bridge CFStringRef)[fileName pathExtension], NULL);
    CFStringRef MIMEType = UTTypeCopyPreferredTagWithClass(UTI, kUTTagClassMIMEType);
    CFRelease(UTI);
    if (!MIMEType) {
        return @"application/octet-stream";
    }
    return (__bridge NSString *)(MIMEType);
}


@end
