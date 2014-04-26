//
//  NSStringFromAnyObjectAppTests.m
//  NSStringFromAnyObjectAppTests
//
//  Created by Stanislaw Pankevich on 26/04/14.
//  Copyright (c) 2014 Stanislaw Pankevich. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "NSStringFromAnyObject.h"

#import "UIKit.h"

@interface NSStringFromAnyObjectForAdditionalFrameworksTests : XCTestCase

@end

@implementation NSStringFromAnyObjectForAdditionalFrameworksTests

- (void)testNSStringFromAnyObject {
    NSString *objectRepresentation;


#pragma mark UIKit


    objectRepresentation = NSStringFromAnyObject( CGRectMake(0, 0, 200, 200) );
    XCTAssertTrue([objectRepresentation isEqualToString:@"(CGRect){0.000000, 0.000000, 200.000000, 200.000000}"]);


    objectRepresentation = NSStringFromAnyObject( CGPointMake(0, 0) );
    XCTAssertTrue([objectRepresentation isEqualToString:@"(CGPoint){0.000000, 0.000000}"]);


    objectRepresentation = NSStringFromAnyObject( CGSizeMake(0, 0) );
    XCTAssertTrue([objectRepresentation isEqualToString:@"(CGSize){0.000000, 0.000000}"]);


}

@end
