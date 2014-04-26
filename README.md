# NSStringFromAnyObject

NSStringFromAnyObject creation is caused by evolution of [EchoLogger project](https://github.com/stanislaw/EchoLogger) which used to provide the same functionality: `NSString representations for arbitrary objects (be it Objective-C or C objects)` by means of `Clang`'s `__attribute__((overloadable))`.  

NSStringFromAnyObject uses Objective-C Runtime introspection instead, as it appears to be a more consistent approach (though probably a bit slower). It is inspired by [ATLog project](https://github.com/rabovik/ATLog) written by Yan Rabovik. 

NSStringFromAnyObject can be extended with additional "any object handlers": see how the handlers for objects of MapKit, UIKit, CoreLocation are written: they are decoupled from main C/Objective-C "any objects handler" so they can be included manually if these frameworks are needed. Browse the code to see how to write custom handlers.

Feedback is highly appreciated!

## Example

```objective-c
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

## Unsupported types

Because of its hackery based on `void *` NSStringFromAnyObject does not work for the following types of data:

* String literals

```objective-c
char str1[] = "12345";
char str2[6] = "12345";

NSLog(@"%@", NSStringFromAnyObject(str1));
NSLog(@"%@", NSStringFromAnyObject(str2));

=>

NSStringFromAnyObject: unsupported type: ([6c])
NSStringFromAnyObject: unsupported type: ([6c])
```

* C arrays (excluding C strings)

```objective-c
int *nums = malloc(3 * sizeof(int));

nums[0] = 1;
nums[1] = 2;
nums[2] = 3;

NSLog(@"%@", NSStringFromAnyObject(nums));

=>

NSStringFromAnyObject: unsupported type: (^i)
```

All other common types of objects are known to be supported.

----

## Copyright

Copyright (c) 2014 Stanislaw Pankevich. See LICENSE for details.


