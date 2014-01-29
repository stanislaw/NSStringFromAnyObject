#import <Foundation/Foundation.h>
#import "UIKit.h"

#import "NSStringFromAnyObject.h"

int main(int argc, const char * argv[])
{
    @autoreleasepool {
        NSString *objectRepresentation;

        // Objective-C

        objectRepresentation = NSStringFromAnyObject( nil );
        printf("%s\n", [objectRepresentation cStringUsingEncoding:NSUTF8StringEncoding]);

        objectRepresentation = NSStringFromAnyObject( @[ @(1) ] );
        printf("%s\n", [objectRepresentation cStringUsingEncoding:NSUTF8StringEncoding]);

        objectRepresentation = NSStringFromAnyObject( @(1) );
        printf("%s\n", [objectRepresentation cStringUsingEncoding:NSUTF8StringEncoding]);

        objectRepresentation = NSStringFromAnyObject( [@(1) class] );
        printf("%s\n", [objectRepresentation cStringUsingEncoding:NSUTF8StringEncoding]);

        objectRepresentation = NSStringFromAnyObject( @selector(main) );
        printf("%s\n", [objectRepresentation cStringUsingEncoding:NSUTF8StringEncoding]);

        // Foundation

        objectRepresentation = NSStringFromAnyObject( NSMakeRange(0, 10) );
        printf("%s\n", [objectRepresentation cStringUsingEncoding:NSUTF8StringEncoding]);

        // C pointers

        objectRepresentation = NSStringFromAnyObject( NULL );
        printf("%s\n", [objectRepresentation cStringUsingEncoding:NSUTF8StringEncoding]);

        void *ptr = &printf;
        objectRepresentation = NSStringFromAnyObject( ptr );
        printf("%s\n", [objectRepresentation cStringUsingEncoding:NSUTF8StringEncoding]);

        const void *const_ptr = &printf;
        objectRepresentation = NSStringFromAnyObject( const_ptr );
        printf("%s\n", [objectRepresentation cStringUsingEncoding:NSUTF8StringEncoding]);

        // C numbers

        objectRepresentation = NSStringFromAnyObject( (BOOL)YES );
        printf("%s\n", [objectRepresentation cStringUsingEncoding:NSUTF8StringEncoding]);

        objectRepresentation = NSStringFromAnyObject( 1.24 );
        printf("%s\n", [objectRepresentation cStringUsingEncoding:NSUTF8StringEncoding]);

        objectRepresentation = NSStringFromAnyObject( 1.24f );
        printf("%s\n", [objectRepresentation cStringUsingEncoding:NSUTF8StringEncoding]);

        objectRepresentation = NSStringFromAnyObject( 1 );
        printf("%s\n", [objectRepresentation cStringUsingEncoding:NSUTF8StringEncoding]);

        objectRepresentation = NSStringFromAnyObject( (short)1 );
        printf("%s\n", [objectRepresentation cStringUsingEncoding:NSUTF8StringEncoding]);

        objectRepresentation = NSStringFromAnyObject( (long)1000L );
        printf("%s\n", [objectRepresentation cStringUsingEncoding:NSUTF8StringEncoding]);

        objectRepresentation = NSStringFromAnyObject( (long long)100000000000LL );
        printf("%s\n", [objectRepresentation cStringUsingEncoding:NSUTF8StringEncoding]);

        objectRepresentation = NSStringFromAnyObject( (char)'c' );
        printf("%s\n", [objectRepresentation cStringUsingEncoding:NSUTF8StringEncoding]);

        objectRepresentation = NSStringFromAnyObject( (unsigned char)'c' );
        printf("%s\n", [objectRepresentation cStringUsingEncoding:NSUTF8StringEncoding]);

        // C strings

        char *str = "A string";
        const char *conststr = (const char *)str;

        objectRepresentation = NSStringFromAnyObject( str );
        printf("%s\n", [objectRepresentation cStringUsingEncoding:NSUTF8StringEncoding]);
        
        objectRepresentation = NSStringFromAnyObject( conststr );
        printf("%s\n", [objectRepresentation cStringUsingEncoding:NSUTF8StringEncoding]);
        
        // UIKit

        objectRepresentation = NSStringFromAnyObject( CGRectMake(0, 0, 200, 200) );
        printf("%s\n", [objectRepresentation cStringUsingEncoding:NSUTF8StringEncoding]);

        objectRepresentation = NSStringFromAnyObject( CGPointMake(0, 0) );
        printf("%s\n", [objectRepresentation cStringUsingEncoding:NSUTF8StringEncoding]);

        objectRepresentation = NSStringFromAnyObject( CGSizeMake(0, 0) );
        printf("%s\n", [objectRepresentation cStringUsingEncoding:NSUTF8StringEncoding]);
    }

    return 0;
}
