# NSStringFromAnyObject

## Example

```objective-c
#import <Foundation/Foundation.h>
#import "UIKit.h"

#import "NSStringFromAnyObject.h"

int main(int argc, const char * argv[])
{
    @autoreleasepool {
        NSString *anyObjectInspection;

        // Objective-C

        anyObjectInspection = NSStringFromAnyObject( nil );
        printf("%s\n", [anyObjectInspection cStringUsingEncoding:NSUTF8StringEncoding]);

        anyObjectInspection = NSStringFromAnyObject( @[ @(1) ] );
        printf("%s\n", [anyObjectInspection cStringUsingEncoding:NSUTF8StringEncoding]);

        anyObjectInspection = NSStringFromAnyObject( @(1) );
        printf("%s\n", [anyObjectInspection cStringUsingEncoding:NSUTF8StringEncoding]);

        anyObjectInspection = NSStringFromAnyObject( [@(1) class] );
        printf("%s\n", [anyObjectInspection cStringUsingEncoding:NSUTF8StringEncoding]);

        anyObjectInspection = NSStringFromAnyObject( @selector(main) );
        printf("%s\n", [anyObjectInspection cStringUsingEncoding:NSUTF8StringEncoding]);

        // Foundation

        anyObjectInspection = NSStringFromAnyObject( NSMakeRange(0, 10) );
        printf("%s\n", [anyObjectInspection cStringUsingEncoding:NSUTF8StringEncoding]);

        // C pointers

        anyObjectInspection = NSStringFromAnyObject( NULL );
        printf("%s\n", [anyObjectInspection cStringUsingEncoding:NSUTF8StringEncoding]);

        void *ptr = &printf;
        anyObjectInspection = NSStringFromAnyObject( ptr );
        printf("%s\n", [anyObjectInspection cStringUsingEncoding:NSUTF8StringEncoding]);

        const void *const_ptr = &printf;
        anyObjectInspection = NSStringFromAnyObject( const_ptr );
        printf("%s\n", [anyObjectInspection cStringUsingEncoding:NSUTF8StringEncoding]);

        // C numbers

        anyObjectInspection = NSStringFromAnyObject( (BOOL)YES );
        printf("%s\n", [anyObjectInspection cStringUsingEncoding:NSUTF8StringEncoding]);

        anyObjectInspection = NSStringFromAnyObject( 1.24 );
        printf("%s\n", [anyObjectInspection cStringUsingEncoding:NSUTF8StringEncoding]);

        anyObjectInspection = NSStringFromAnyObject( 1.24f );
        printf("%s\n", [anyObjectInspection cStringUsingEncoding:NSUTF8StringEncoding]);

        anyObjectInspection = NSStringFromAnyObject( 1 );
        printf("%s\n", [anyObjectInspection cStringUsingEncoding:NSUTF8StringEncoding]);

        anyObjectInspection = NSStringFromAnyObject( (short)1 );
        printf("%s\n", [anyObjectInspection cStringUsingEncoding:NSUTF8StringEncoding]);

        anyObjectInspection = NSStringFromAnyObject( (long)1000L );
        printf("%s\n", [anyObjectInspection cStringUsingEncoding:NSUTF8StringEncoding]);

        anyObjectInspection = NSStringFromAnyObject( (long long)100000000000LL );
        printf("%s\n", [anyObjectInspection cStringUsingEncoding:NSUTF8StringEncoding]);

        anyObjectInspection = NSStringFromAnyObject( (char)'c' );
        printf("%s\n", [anyObjectInspection cStringUsingEncoding:NSUTF8StringEncoding]);

        anyObjectInspection = NSStringFromAnyObject( (unsigned char)'c' );
        printf("%s\n", [anyObjectInspection cStringUsingEncoding:NSUTF8StringEncoding]);

        // C strings

        char *str = "A string";
        const char *conststr = (const char *)str;

        anyObjectInspection = NSStringFromAnyObject( str );
        printf("%s\n", [anyObjectInspection cStringUsingEncoding:NSUTF8StringEncoding]);
        
        anyObjectInspection = NSStringFromAnyObject( conststr );
        printf("%s\n", [anyObjectInspection cStringUsingEncoding:NSUTF8StringEncoding]);
        
        // UIKit

        anyObjectInspection = NSStringFromAnyObject( CGRectMake(0, 0, 200, 200) );
        printf("%s\n", [anyObjectInspection cStringUsingEncoding:NSUTF8StringEncoding]);

        anyObjectInspection = NSStringFromAnyObject( CGPointMake(0, 0) );
        printf("%s\n", [anyObjectInspection cStringUsingEncoding:NSUTF8StringEncoding]);

        anyObjectInspection = NSStringFromAnyObject( CGSizeMake(0, 0) );
        printf("%s\n", [anyObjectInspection cStringUsingEncoding:NSUTF8StringEncoding]);
    }

    return 0;
}
```

```
nil/NULL
(__NSArrayI)(
    1
)
@(1)
(Class)__NSCFNumber
(SEL)main
(NSRange){0, 10}
nil/NULL
(void *)0x7fff88bd7948
(const void *)0x7fff88bd7948
YES
(double)1.240000
(float)1.240000
(int)1
(short)1
(long)1000
(long)100000000000
(char)c
(unsigned char)c
(char *)A string
(const char *)A string
(CGRect){0.000000, 0.000000, 200.000000, 200.000000}
(CGPoint){0.000000, 0.000000}
(CGSize){0.000000, 0.000000}
Program ended with exit code: 0
```

