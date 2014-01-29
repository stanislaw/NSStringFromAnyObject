

#import <MapKit/MKGeometry.h>

static inline NSString *__NSStringFromMapKitObject(const char *type, const void *object) {


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

