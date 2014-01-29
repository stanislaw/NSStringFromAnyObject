
#import "NSStringFromAnyObject.h"


typedef NSString * (* NSStringFromAnyObjectHandler)(const char *type, const void *object);


static const int NSStringFromAnyObjectHandlersMax = 4;
static NSStringFromAnyObjectHandler NSStringFromAnyObjectHandlers[NSStringFromAnyObjectHandlersMax] = { NULL };


void __NSStringFromAnyObjectAdd(NSStringFromAnyObjectHandler function) {
    for (int i = 0; i < NSStringFromAnyObjectHandlersMax; i++) {
        if (NSStringFromAnyObjectHandlers[i] == NULL) {
            NSStringFromAnyObjectHandlers[i] = function;
            return;
        }
    }

    assert("__NSStringFromAnyObjectAdd: limit of handlers is reached");
}


NSString *__NSStringFromAnyObject(const char *type, const void *object) {

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
    
    
    // Here finite strings, structs, ...


    // Additional handlers
    for (int i = 0; i < NSStringFromAnyObjectHandlersMax; i++) {
        NSStringFromAnyObjectHandler handler = NSStringFromAnyObjectHandlers[i];

        if (handler != NULL) {
            NSString *string = handler(type, object);

            if (string) {
                return string;
            }
        }
    }

    
    return [NSString stringWithFormat:@"NSStringFromAnyObject: unsupported type: (%s)", type];
}

