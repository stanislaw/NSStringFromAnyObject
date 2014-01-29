//
// NSStringFromAnyObject.h
//
// NSStringFromAnyObject creation is caused by development needs of EchoLogger project written by Stanislaw Pankevich:
//
// https://github.com/stanislaw/EchoLogger
//
// which used to provide analogous functionality: debug strings for arbitrary objects be it an Objective-C or C objects -
// by means of CLANG's __attribute__((overloadable)).
//
// NSStringFromAnyObject uses Objective-C Runtime introspection instead, which seems to be a more consistent approach:
// it is inspired by ATLog project written by Yan Rabovik:
//
// https://github.com/rabovik/ATLog
//
// More specifically it borrows the trick which allows passing Objective-C objects as void * arguments:
//
// ```
// @encode(__typeof__(anyobject)), (__typeof__(anyobject) []){ anyobject }
// ```
//
// Created by Stanislaw Pankevich on 29/01/14.
// Copyright (c) 2014 Stanislaw Pankevich. All rights reserved.
// Copyright (C) 2013 Yan Rabovik

/*
 *
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use, copy,
 * modify, merge, publish, distribute, sublicense, and/or sell copies
 * of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY
 * CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
 * CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
 * WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 * Except as contained in this notice, the names of the authors or
 * their institutions shall not be used in advertising or otherwise to
 * promote the sale, use or other dealings in this Software without
 * prior written authorization from the authors.
 */


#import <Foundation/Foundation.h>


static inline NSString *__NSStringFromAnyObject(const char *type, const void *object) {

#pragma mark Objective-C

    switch (type[0]) {
        case '@': {
            __unsafe_unretained id _object = *(__unsafe_unretained id *)object;

            if ([_object isKindOfClass:[NSNumber class]]) {
                return [NSString stringWithFormat:@"@(%@)", _object];
            }

            return [NSString stringWithFormat:@"(%@)%@", [_object class], _object];
        }

        case '#': {
            return [NSString stringWithFormat:@"(Class)%@", *(Class *)object];
        }

        case ':': {
            return [NSString stringWithFormat:@"(SEL)%@", NSStringFromSelector(*(SEL *)object)];
        }

        default:
            break;
    }

#pragma mark Foundation

    if (strcmp(@encode(NSRange), type) == 0) {
        return [NSString stringWithFormat:@"(NSRange)%@", NSStringFromRange((*(NSRange *)object))];
    }

#pragma mark C pointers

    if (strcmp(@encode(void *), type) == 0){
        void *pointer = *(void **)object;

        if (pointer == NULL) {
            return @"nil/NULL";
        }

        return [NSString stringWithFormat:@"(void *)%p",pointer];
    }

    if (strcmp(@encode(const void *), type) == 0){
        const void *pointer = *(void **)object;
        if (NULL == pointer) return @"(const void *)NULL";
        return [NSString stringWithFormat:@"(const void *)%p",pointer];
    }

#pragma mark C numeric types

    if (strcmp(@encode(BOOL), type) == 0){
        if (strcmp(@encode(BOOL), @encode(signed char)) == 0){
            // 32 bit
            char ch = *(signed char *)object;
            if ((char)YES == ch) return @"YES";
            if ((char)NO == ch) return @"NO";
        }else if (strcmp(@encode(BOOL), @encode(bool)) == 0){
            // 64 bit
            bool boolValue = *(bool *)object;
            if (boolValue) {
                return @"YES";
            }else{
                return @"NO";
            }
        }
    }

    if (strcmp(@encode(double), type) == 0) {
        return [NSString stringWithFormat:@"(double)%f",*(double *)object];
    }

    if (strcmp(@encode(float), type) == 0){
        return [NSString stringWithFormat:@"(float)%f",*(float *)object];
    }

    if (strcmp(@encode(int), type) == 0){
        return [NSString stringWithFormat:@"(int)%d",*(int *)object];
    }

    if (strcmp(@encode(short), type) == 0){
        return [NSString stringWithFormat:@"(short)%d",*(short *)object];
    }

    if (strcmp(@encode(long), type) == 0){
        return [NSString stringWithFormat:@"(long)%ld", *(long *)object];
    }

    if (strcmp(@encode(long long), type) == 0) {
        return [NSString stringWithFormat:@"(long long)%lld", *(long long *)object];
    }

    if (strcmp(@encode(char), type) == 0){
        char ch = *(char *)object;
        return [NSString stringWithFormat:@"(char)%c",ch];
    }

    if (strcmp(@encode(unsigned char), type) == 0){
        return [NSString stringWithFormat:@"(unsigned char)%c", *(unsigned char *)object];
    }

    if (strcmp(@encode(unsigned int), type) == 0){
        return [NSString stringWithFormat:@"%u", *(unsigned int *)object];
    }

    if (strcmp(@encode(unsigned short), type) == 0){
        return [NSString stringWithFormat:@"%u", *(unsigned short *)object];
    }

    if (strcmp(@encode(unsigned long), type) == 0){
        return [NSString stringWithFormat:@"%lu", *(unsigned long *)object];
    }

    if (strcmp(@encode(unsigned long long), type) == 0){
        return [NSString stringWithFormat:@"%llu", *(unsigned long long *)object];
    }

#pragma mark C char * strings

    if (strcmp(@encode(const char *), type) == 0) {
        return [NSString stringWithFormat:@"(const char *)%s", *(const char **)object];
    }

    if (strcmp(@encode(char *), type) == 0) {
        return [NSString stringWithFormat:@"(char *)%s", *(const char **)object];
    }
    

#pragma mark UIKit

#ifdef CGGEOMETRY_H_

    if (strcmp(@encode(CGRect), type) == 0) {
        CGRect rect = *(CGRect *)object;
        return [NSString stringWithFormat:@"(CGRect){%f, %f, %f, %f}", rect.origin.x, rect.origin.y, rect.size.width, rect.size.height];
    }

    if (strcmp(@encode(CGSize), type) == 0) {
        CGSize size = *(CGSize *)object;
        return [NSString stringWithFormat:@"(CGSize){%f, %f}", size.width, size.height];
    }

    if (strcmp(@encode(CGPoint), type) == 0) {
        CGPoint point = *(CGPoint *)object;
        return [NSString stringWithFormat:@"(CGPoint){%f, %f}", point.x, point.y];
    }

#endif

#pragma mark MapKit

#ifdef MK_EXTERN

    if (strcmp(@encode(MKMapRect), type) == 0) {
        MKMapRect rect = *(MKMapRect *)object;
        return [NSString stringWithFormat:@"(MKMapRect){%f, %f, %f, %f}", rect.origin.x, rect.origin.y, rect.size.width, rect.size.height];
    }

    if (strcmp(@encode(MKMapSize), type) == 0) {
        MKMapSize size = *(MKMapSize *)object;
        return [NSString stringWithFormat:@"(MKMapSize){%f, %f}", size.width, size.height];
    }

    if (strcmp(@encode(MKMapPoint), type) == 0) {
        MKMapPoint point = *(MKMapPoint *)object;
        return [NSString stringWithFormat:@"(MKMapPoint){%f, %f}", point.x, point.y];
    }

    if (strcmp(@encode(MKCoordinateRegion), type) == 0) {
        MKCoordinateRegion region = *(MKCoordinateRegion *)object;
        return [NSString stringWithFormat:@"(MKCoordinateRegion){%f, %f, %f, %f}", region.center.latitude, region.center.longitude, region.span.latitudeDelta, region.span.longitudeDelta];
    }

#endif

#pragma mark CoreLocation

#ifdef CL_EXTERN

    if (strcmp(@encode(CLLocationCoordinate2D), type) == 0) {
        CLLocationCoordinate2D coordinate = *(CLLocationCoordinate2D *)object;
        return [NSString stringWithFormat:@"(CLLocationCoordinate2D){%f, %f}", coordinate.latitude, coordinate.longitude];
    }

#endif


    // Here finite strings, structs, ...



    return [NSString stringWithFormat:@"NSStringFromAnyObject: unsupported type: (%s)", type];
}


#define NSStringFromAnyObject(anyobject) \
    __NSStringFromAnyObject(@encode(__typeof__(anyobject)), (__typeof__(anyobject) []){ anyobject })

