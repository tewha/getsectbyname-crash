//
//  main.m
//  getsectbyname
//
//  Created by Steven Fisher on 2015-03-10.
//  Copyright (c) 2015 Steven Fisher. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <mach-o/getsect.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // This works in debug or release configurations, but only if run by Xcode.
        
        //        NSError *e;
        const struct section_64 *plistSection = getsectbyname("__TEXT", "__info_plist");
        NSLog(@"Found a section %s, %s", plistSection->segname, plistSection->sectname);
        void *ptr = ((void *)plistSection->addr);
        uint64_t size = plistSection->size;
        
        NSLog(@"It has %zd bytes at %tx", size, plistSection->addr);
        NSLog(@"Allocating %zd bytes", size);
        void *buffer = malloc(size);
        NSLog(@"Moving %zd bytes", size);
        NSLog(@"(This will crash when run in Terminal, but work when run from Xcode. Debug or no doesn't matter.)");
        memmove(buffer, ptr, size);
        NSLog(@"Freeing %zd bytes", size);
        free(buffer);
        
        //        NSData *plistData = [NSData dataWithBytesNoCopy:ptr length:size freeWhenDone:NO];
        //        NSPropertyListFormat format;
        //        NSDictionary *infoPlistContents =  [NSPropertyListSerialization propertyListWithData:plistData options:NSPropertyListImmutable format:&format error:&e];
        //        NSLog(@"The value for Key is %@", infoPlistContents[@"Key"]);
    }
    return 0;
}
