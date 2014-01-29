//
//  main.m
//  NSStringFromAnyObjectCommandLineApp
//
//  Created by Stanislaw Pankevich on 29/01/14.
//  Copyright (c) 2014 Stanislaw Pankevich. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NSStringFromAnyObject.h"

#import "UIKit.h"
#import "CoreLocation.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        NSString *anyObjectInspection;

        anyObjectInspection = NSStringFromAnyObject( nil );
        NSLog(@"%@", anyObjectInspection);

        anyObjectInspection = NSStringFromAnyObject( @[ @(1) ] );
        NSLog(@"%@", anyObjectInspection);

        anyObjectInspection = NSStringFromAnyObject( @(1) );
        NSLog(@"%@", anyObjectInspection);

        anyObjectInspection = NSStringFromAnyObject( [@(1) class] );
        NSLog(@"%@", anyObjectInspection);

        anyObjectInspection = NSStringFromAnyObject( @selector(main) );
        NSLog(@"%@", anyObjectInspection);

        anyObjectInspection = NSStringFromAnyObject( NSMakeRange(0, 10) );
        NSLog(@"%@", anyObjectInspection);


        anyObjectInspection = NSStringFromAnyObject( NULL );
        NSLog(@"%@", anyObjectInspection);

        void *ptr = &printf;
        anyObjectInspection = NSStringFromAnyObject( ptr );
        NSLog(@"%@", anyObjectInspection);

        const void *const_ptr = &printf;
        anyObjectInspection = NSStringFromAnyObject( const_ptr );
        NSLog(@"%@", anyObjectInspection);


        anyObjectInspection = NSStringFromAnyObject( (BOOL)YES );
        NSLog(@"BOOL: %@", anyObjectInspection);

        anyObjectInspection = NSStringFromAnyObject( 1.24 );
        NSLog(@"double: %@", anyObjectInspection);

        anyObjectInspection = NSStringFromAnyObject( 1.24f );
        NSLog(@"float: %@", anyObjectInspection);

        anyObjectInspection = NSStringFromAnyObject( 1 );
        NSLog(@"int: %@", anyObjectInspection);

        anyObjectInspection = NSStringFromAnyObject( (short)1 );
        NSLog(@"short: %@", anyObjectInspection);

        anyObjectInspection = NSStringFromAnyObject( (long)1000L );
        NSLog(@"long: %@", anyObjectInspection);

        anyObjectInspection = NSStringFromAnyObject( (long long)100000000000LL );
        NSLog(@"long long: %@", anyObjectInspection);

        anyObjectInspection = NSStringFromAnyObject( (char)'c' );
        NSLog(@"signed char: %@", anyObjectInspection);

        anyObjectInspection = NSStringFromAnyObject( (unsigned char)'c' );
        NSLog(@"unsigned char: %@", anyObjectInspection);


        char *str = "A string";
        const char *conststr = (const char *)str;

        anyObjectInspection = NSStringFromAnyObject( str );
        NSLog(@"char *: %@", anyObjectInspection);
        
        anyObjectInspection = NSStringFromAnyObject( conststr );
        NSLog(@"const char *: %@", anyObjectInspection);
        

        // UIKit

        anyObjectInspection = NSStringFromAnyObject( CGRectMake(0, 0, 200, 200) );
        NSLog(@"%@", anyObjectInspection);

        anyObjectInspection = NSStringFromAnyObject( CGPointMake(0, 0) );
        NSLog(@"%@", anyObjectInspection);

        anyObjectInspection = NSStringFromAnyObject( CGSizeMake(0, 0) );
        NSLog(@"%@", anyObjectInspection);

        // CoreLocation
    }

    return 0;
}

