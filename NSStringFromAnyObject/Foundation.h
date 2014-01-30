
#import <Foundation/Foundation.h>


static inline NSString *__NSStringFromFoundationObject(const char *type, const void *object) {

    if (strcmp(@encode(NSRange), type) == 0) {
        return [NSString stringWithFormat:@"(NSRange)%@", NSStringFromRange((*(NSRange *)object))];
    }

    return nil;
}

