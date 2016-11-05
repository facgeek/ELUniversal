//
//  Services.h
//


#import <Foundation/Foundation.h>
#import "ResultadoOperacionDTO.h"


@interface Services : NSObject
{
    void (^_callbackHandler)(ResultadoOperacionDTO *resultadoOperacion);
    
}

#pragma mark -
#pragma mark == CallWebServices ==
#pragma mark -


+ (void) getNotasElUniversal : (int) pagina
                    complete : (void (^)(ResultadoOperacionDTO *))handler;

#pragma mark -
#pragma mark == Response Claro ==
#pragma mark -

+ (void) responseWebServices  : (int) pagina
                          url : (NSString *) url
                     complete : (void (^)(ResultadoOperacionDTO *))handler;


@end
