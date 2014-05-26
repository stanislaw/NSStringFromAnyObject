
#import "NSStringFromAnyObject.h"


// Default handlers
#import "ObjC.h"
#import "C.h"
#import "Foundation.h"


typedef NSString * (* NSStringFromAnyObjectHandler)(const char *type, const void *object);


static const int NSStringFromAnyObjectHandlersMax = 8;
static NSStringFromAnyObjectHandler NSStringFromAnyObjectHandlers[NSStringFromAnyObjectHandlersMax] = {
    __NSStringFromObjCObject,
    __NSStringFromCObject,
    __NSStringFromFoundationObject,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
};


void __NSStringFromAnyObjectAddHandler(NSStringFromAnyObjectHandler handler) {
    for (int i = 0; i < NSStringFromAnyObjectHandlersMax; i++) {
        if (NSStringFromAnyObjectHandlers[i] == NULL) {
            NSStringFromAnyObjectHandlers[i] = handler;
            return;
        }
    }

    assert("__NSStringFromAnyObjectAdd: limit of handlers is reached");
}


NSString *__NSStringFromAnyObject(const char *type, const void *object) {

    
    for (int i = 0; i < NSStringFromAnyObjectHandlersMax; i++) {
        NSStringFromAnyObjectHandler handler = NSStringFromAnyObjectHandlers[i];

        if (handler != NULL) {
            NSString *string = handler(type, object);

            if (string) {
                return string;
            }
        }
    }


    return [NSString stringWithFormat:@"NSStringFromAnyObject: unsupported type: %s", type];
}

