//
//  main.m
//  define
//
//  Created by Beau Galbraith on 8/25/16.
//  Copyright © 2016 Beau Galbraith. All rights reserved.
//
// Command line tool
// Uses Apple's builtin dictionary (i.e. no network activity)
// Version 0.1 I guess..?

#import <Foundation/Foundation.h>
@import CoreServices;
#define NSLogC(FORMAT, ...) printf("%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        NSString* help = @"Search word in your Mac's built-in dictionary";
        NSString* noArgs =@"Usage: define <word> [-v]";
        NSArray *args = [[NSProcessInfo processInfo] arguments];
        
        
        NSMutableString *multiWord;
        if([args count] > 1){
            multiWord = [NSMutableString stringWithString: args[1]];
        } else {
            NSLogC(@"%@", noArgs);
            NSLogC(@"%@", help);
            return 1;
        }

        
        for (int i = 1; i < [args count]; ++i){
            if([args[i] hasPrefix:@"-h"] || [args[i] hasPrefix:@"--h"]){
                NSLogC(@"%@", help);
                break;
            }

        }
        CFRange wlength = DCSGetTermRangeInString(NULL, (__bridge CFStringRef _Nonnull)(multiWord), 0);
        CFStringRef definition = DCSCopyTextDefinition(NULL,(__bridge CFStringRef _Nonnull)(multiWord), wlength);
        if(definition){
            NSLogC(@"%@", definition);
        } else {
            NSLogC(@"%@ not found. Try adding a hyphen or space for compound words", multiWord);
        }
    }
    return 0;
}
