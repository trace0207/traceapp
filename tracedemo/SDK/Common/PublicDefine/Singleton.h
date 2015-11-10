//
//  Singleton.h
//
//
//  Created by sjxu on 12-12-24.
//  Copyright (c) 2012年 sjxu. All rights reserved.
//

#ifndef frame_Singleton_h
#define frame_Singleton_h


/// This macro implements the various methods needed to make a safe singleton.
/// Sample usage:
/// OBJECTIVE_C_SINGLETON_(SomeUsefulManager, sharedSomeUsefulManager)
/// (with no trailing semicolon)

#define SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(_object_name_, _shared_obj_name_)         \
                                                                                        \
+ (_object_name_*) _shared_obj_name_;                                                   \


#if __has_feature(objc_arc)


#define SYNTHESIZE_SINGLETON_FOR_CLASS_PROTOTYPE(_object_name_, _shared_obj_name_)      \
                                                                                        \
+ (_object_name_ *) _shared_obj_name_                                                   \
{                                                                                       \
    static _object_name_ *z##_shared_obj_name_;											\
                                                                                        \
    static dispatch_once_t done;														\
                                                                                        \
    dispatch_once(&done, ^{z##_shared_obj_name_ = [_object_name_ new]; });				\
                                                                                        \
    return z##_shared_obj_name_;                                                        \
}



#else

#define SYNTHESIZE_SINGLETON_FOR_CLASS_PROTOTYPE(_object_name_, _shared_obj_name_)      \
                                                                                        \
static _object_name_ *z##_shared_obj_name_ = nil;                                       \
                                                                                        \
+ (_object_name_ *) _shared_obj_name_                                                   \
{                                                                                       \
    @synchronized(self)   {                                                             \
        if (z##_shared_obj_name_ == nil) {                                              \
            z##_shared_obj_name_ = [NSAllocateObject([self class], 0, NULL) init];      \
        }                                                                               \
    }                                                                                   \
                                                                                        \
    return z##_shared_obj_name_;                                                        \
}                                                                                       \
                                                                                        \
+ (id) allocWithZone:(NSZone *)zone                                                     \
{                                                                                       \
	return [[self _shared_obj_name_] retain];											\
}                                                                                       \
                                                                                        \
- (id) copyWithZone:(NSZone *)zone                                                      \
{                                                                                       \
    return self;																		\
}                                                                                       \
                                                                                        \
- (id) retain                                                                           \
{                                                                                       \
	return self;                                                                        \
}                                                                                       \
                                                                                        \
- (NSUInteger) retainCount                                                              \
{                                                                                       \
	return NSUIntegerMax;  /* so the singleton object cannot be released */             \
}                                                                                       \
                                                                                        \
- (oneway void) release                                                                 \
{                                                                                       \
                                                                                        \
}                                                                                       \
                                                                                        \
- (id) autorelease                                                                      \
{                                                                                       \
	return self;                                                                        \
}                                                                                       \


#endif

#endif
