//
//  NSStringFromAnyObjectAppTests.m
//  NSStringFromAnyObjectAppTests
//
//  Created by Stanislaw Pankevich on 26/04/14.
//  Copyright (c) 2014 Stanislaw Pankevich. All rights reserved.
//


#import <XCTest/XCTest.h>


#import "NSStringFromAnyObject.h"


@interface NSStringFromAnyObjectAppTests : XCTestCase

@end

@implementation NSStringFromAnyObjectAppTests


#pragma mark - NSStringFromAnyObject


- (void)test_NSStringFromAnyObject {
    NSString *objectRepresentation, *output;


#pragma mark Objective-C


    objectRepresentation = NSStringFromAnyObject( nil );
    XCTAssertTrue([objectRepresentation isEqualToString:@"nil/NULL"]);


    objectRepresentation = NSStringFromAnyObject( @[ @(1) ] );
    XCTAssertTrue([objectRepresentation isEqualToString:@"(__NSArrayI)(\n    1\n)"]);

    objectRepresentation = NSStringFromAnyObject( @(1) );
    XCTAssertTrue([objectRepresentation isEqualToString:@"@(1)"]);

    objectRepresentation = NSStringFromAnyObject( [@(1) class] );
    XCTAssertTrue([objectRepresentation isEqualToString:@"(Class)__NSCFNumber"]);

    objectRepresentation = NSStringFromAnyObject( @selector(main) );
    XCTAssertTrue([objectRepresentation isEqualToString:@"(SEL)main"]);


#pragma mark Foundation


    objectRepresentation = NSStringFromAnyObject( NSMakeRange(0, 10) );
    XCTAssertTrue([objectRepresentation isEqualToString:@"(NSRange){0, 10}"]);


#pragma mark C Pointers


    objectRepresentation = NSStringFromAnyObject( NULL );
    XCTAssertTrue([objectRepresentation isEqualToString:@"nil/NULL"]);


    void *ptr = &printf;
    objectRepresentation = NSStringFromAnyObject( ptr );
    output = [NSString stringWithFormat:@"(void *)%p", ptr];
    XCTAssertTrue([objectRepresentation isEqualToString:output]);


    const void *const_ptr = &printf;
    objectRepresentation = NSStringFromAnyObject( const_ptr );
    output = [NSString stringWithFormat:@"(const void *)%p", ptr];
    XCTAssertTrue([objectRepresentation isEqualToString:output]);


#pragma mark C Numbers


    objectRepresentation = NSStringFromAnyObject( (BOOL)YES );
    XCTAssertTrue([objectRepresentation isEqualToString:@"YES"]);
    objectRepresentation = NSStringFromAnyObject( (BOOL)NO );
    XCTAssertTrue([objectRepresentation isEqualToString:@"NO"]);


    objectRepresentation = NSStringFromAnyObject( 1.24 );
    XCTAssertTrue([objectRepresentation isEqualToString:@"(double)1.240000"]);


    objectRepresentation = NSStringFromAnyObject( 1.24f );
    XCTAssertTrue([objectRepresentation isEqualToString:@"(float)1.240000f"]);


    objectRepresentation = NSStringFromAnyObject( 1 );
    XCTAssertTrue([objectRepresentation isEqualToString:@"(int)1"]);


    objectRepresentation = NSStringFromAnyObject( (short)1 );
    XCTAssertTrue([objectRepresentation isEqualToString:@"(short)1"]);


    objectRepresentation = NSStringFromAnyObject( (long)1000L );
    XCTAssertTrue([objectRepresentation isEqualToString:@"(long)1000L"]);


    objectRepresentation = NSStringFromAnyObject( (long long)100000000000LL );
    XCTAssertTrue([objectRepresentation isEqualToString:@"(long long)100000000000LL"]);


    objectRepresentation = NSStringFromAnyObject( (char)'c' );
    XCTAssertTrue([objectRepresentation isEqualToString:@"(char)c"]);


    objectRepresentation = NSStringFromAnyObject( (unsigned char)'c' );
    XCTAssertTrue([objectRepresentation isEqualToString:@"(unsigned char)c"]);


#pragma mark C Strings

    
    char *str = "A string";
    const char *conststr = (const char *)str;

    objectRepresentation = NSStringFromAnyObject( str );
    XCTAssertTrue([objectRepresentation isEqualToString:@"(char *)A string"]);

    objectRepresentation = NSStringFromAnyObject( conststr );
    XCTAssertTrue([objectRepresentation isEqualToString:@"(const char *)A string"]);


#pragma mark C Typical Structs


    typedef struct {
        float one;
        float two;
    } TwoFloatsStruct;

    typedef struct {
        TwoFloatsStruct one;
        TwoFloatsStruct two;
    } TwoOfTwoFloatsStruct;

    TwoFloatsStruct twoFloatsStruct = (TwoFloatsStruct){11.0f, 12.0f};
    TwoOfTwoFloatsStruct twoOfTwoFloatsStruct = (TwoOfTwoFloatsStruct){11.0f, 12.0f, 13.0f, 14.0f};

    objectRepresentation = NSStringFromAnyObject( twoFloatsStruct );
    XCTAssertTrue([objectRepresentation isEqualToString:@"(struct){11.000000f, 12.000000f}"]);

    objectRepresentation = NSStringFromAnyObject( twoOfTwoFloatsStruct );
    XCTAssertTrue([objectRepresentation isEqualToString:@"(struct){11.000000f, 12.000000f, 13.000000f, 14.000000f}"]);


    typedef struct {
        double one;
        double two;
    } TwoDoublesStruct;

    typedef struct {
        TwoDoublesStruct one;
        TwoDoublesStruct two;
    } TwoOfTwoDoublesStruct;

    TwoDoublesStruct twoDoublesStruct = (TwoDoublesStruct){11.0f, 12.0f};
    TwoOfTwoDoublesStruct twoOfTwoDoublesStruct = (TwoOfTwoDoublesStruct){11.0, 12.0, 13.0, 14.0};

    objectRepresentation = NSStringFromAnyObject( twoDoublesStruct );
    XCTAssertTrue([objectRepresentation isEqualToString:@"(struct){11.000000, 12.000000}"]);

    objectRepresentation = NSStringFromAnyObject( twoOfTwoDoublesStruct );
    XCTAssertTrue([objectRepresentation isEqualToString:@"(struct){11.000000, 12.000000, 13.000000, 14.000000}"]);
    

}


#pragma mark - NSStringFromAnyObject - Unsupported types


- (void)test_NSStringFromAnyObject_UnsupportedTypes {
    NSString *objectRepresentation;


    objectRepresentation = NSStringFromAnyObject( "String literal" );
    XCTAssertTrue([objectRepresentation isEqualToString:@"NSStringFromAnyObject: unsupported type: [15c]"]);


    typedef struct {
        int x;
        int y;
    } NSSomeStructType;

    NSSomeStructType someStructTypeVariable;
    objectRepresentation = NSStringFromAnyObject( someStructTypeVariable );
    XCTAssertTrue([objectRepresentation isEqualToString:@"NSStringFromAnyObject: unsupported type: {?=ii}"]);


    int *b = malloc(3 * sizeof(int));
    objectRepresentation = NSStringFromAnyObject( b );
    XCTAssertTrue([objectRepresentation isEqualToString:@"NSStringFromAnyObject: unsupported type: ^i"]);
    free(b);
}


@end
