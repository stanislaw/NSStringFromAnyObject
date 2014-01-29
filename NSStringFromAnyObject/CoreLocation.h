

#pragma mark CoreLocation

static inline NSString *__NSStringFromCoreLocationObject(const char *type, const void *object) {

#ifdef CL_EXTERN

    if (strcmp(@encode(CLLocationCoordinate2D), type) == 0) {
        CLLocationCoordinate2D coordinate = *(CLLocationCoordinate2D *)object;
        return [NSString stringWithFormat:@"(CLLocationCoordinate2D){%f, %f}", coordinate.latitude, coordinate.longitude];
    }
    
#endif

    return nil;
}

