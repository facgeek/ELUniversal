

#import "PSStorageRoom.h"
#import <Foundation/NSObject.h>
#import <Foundation/NSNull.h>



id NilOrValue(id aValue) {
    if ((NSNull *)aValue == [NSNull null]) {
        return nil;
    }
    else {
        return aValue;
    }
}
