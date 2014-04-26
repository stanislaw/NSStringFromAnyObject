

static inline NSString *__NSStringFromCObject(const char *type, const void *object) {


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
        }

        else if (strcmp(@encode(BOOL), @encode(bool)) == 0){
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
        return [NSString stringWithFormat:@"(float)%ff",*(float *)object];
    }

    if (strcmp(@encode(int), type) == 0){
        return [NSString stringWithFormat:@"(int)%d",*(int *)object];
    }

    if (strcmp(@encode(short), type) == 0){
        return [NSString stringWithFormat:@"(short)%d",*(short *)object];
    }

    if (strcmp(@encode(long), type) == 0){
        return [NSString stringWithFormat:@"(long)%ldL", *(long *)object];
    }

    if (strcmp(@encode(long long), type) == 0) {
        return [NSString stringWithFormat:@"(long long)%lldLL", *(long long *)object];
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


#pragma mark C typical structs


    if (strcmp("{?=dd}", type) == 0) {
        double firstMember = *((double *)(object));
        double secondMember = *((double *)(object) + 1);

        return [NSString stringWithFormat:@"(struct){%f, %f}", firstMember, secondMember];
    }

    if (strcmp("{?={?=dd}{?=dd}}", type) == 0) {
        double firstMember  = *((double *)(object));
        double secondMember = *((double *)(object) + 1);
        double thirdMember  = *((double *)(object) + 2);
        double fourthMember = *((double *)(object) + 3);

        return [NSString stringWithFormat:@"(struct){%f, %f, %f, %f}", firstMember, secondMember, thirdMember, fourthMember];
    }

    if (strcmp("{?=ff}", type) == 0) {
        float firstMember = *((float *)(object));
        float secondMember = *((float *)(object) + 1);

        return [NSString stringWithFormat:@"(struct){%ff, %ff}", firstMember, secondMember];
    }

    if (strcmp("{?={?=ff}{?=ff}}", type) == 0) {
        float firstMember  = *((float *)(object));
        float secondMember = *((float *)(object) + 1);
        float thirdMember  = *((float *)(object) + 2);
        float fourthMember = *((float *)(object) + 3);

        return [NSString stringWithFormat:@"(struct){%ff, %ff, %ff, %ff}", firstMember, secondMember, thirdMember, fourthMember];
    }


    return nil;

}

