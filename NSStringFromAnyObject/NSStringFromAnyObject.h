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


FOUNDATION_EXPORT void __NSStringFromAnyObjectAddHandler(NSString *(*pointer)(const char *type, const void *object));
FOUNDATION_EXPORT NSString *__NSStringFromAnyObject(const char *type, const void *object);


#define NSStringFromAnyObject(anyobject) \
    __NSStringFromAnyObject(@encode(__typeof__(anyobject)), (__typeof__(anyobject) []){ anyobject })

