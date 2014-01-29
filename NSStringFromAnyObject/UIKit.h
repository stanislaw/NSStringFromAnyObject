
#import <UIKit/UIKit.h>


static inline NSString *__NSStringFromUIKitObject(const char *type, const void *object) {

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

    return nil;

}

