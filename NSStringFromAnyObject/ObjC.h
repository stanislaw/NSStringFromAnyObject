
#import <Foundation/Foundation.h>


static inline NSString *__NSStringFromObjCObject(const char *type, const void *object) {
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

    return nil;
}

