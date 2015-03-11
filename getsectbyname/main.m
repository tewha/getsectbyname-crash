//
//  main.m
//  getsectbyname
//
//  Created by Steven Fisher on 2015-03-10.
//  Copyright (c) 2015 Steven Fisher. All rights reserved.
//

#import <Foundation/Foundation.h>

#include <mach-o/getsect.h>
#include <mach-o/ldsyms.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSError *e;
        unsigned long size;
        void *ptr = getsectiondata(&_mh_execute_header, "__TEXT", "__info_plist", &size);
        NSData *plistData = [NSData dataWithBytesNoCopy:ptr length:size freeWhenDone:NO];
        NSPropertyListFormat format;
        NSDictionary *infoPlistContents =  [NSPropertyListSerialization propertyListWithData:plistData options:NSPropertyListImmutable format:&format error:&e];
        NSLog(@"The value for Key is %@", infoPlistContents[@"Key"]);
    }
    return 0;
}
