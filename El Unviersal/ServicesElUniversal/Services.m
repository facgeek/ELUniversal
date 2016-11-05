//
//  ServicesAxa.m


#import "Services.h"

#define URL_SERVICES @"http://api.eluniversal.com.mx/v1/notes/eluniversal/mxm/json/espectaculos"

#define pageNumber @"0"
#define sizePage @"10"



@implementation Services

#pragma mark -
#pragma mark == CallWebServices ==
#pragma mark -


+ (void) getNotasElUniversal : (int) pagina
                    complete : (void (^)(ResultadoOperacionDTO *))handler {
    
    [self responseWebServices : pagina
                          url : [NSString stringWithFormat:@"%@/%d/%@", URL_SERVICES, pagina, sizePage]
                     complete : handler];
}

#pragma mark -
#pragma mark == Response Claro ==
#pragma mark -

+ (void) responseWebServices  : (int) pagina
                          url : (NSString *) url
                     complete : (void (^)(ResultadoOperacionDTO *))handler{
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL : [NSURL URLWithString: url]
                                                           cachePolicy : NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval : 30.0];
    [request setHTTPMethod:@"GET"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    ResultadoOperacionDTO *resultado = nil;
                                                    if (error) {
                                                        NSLog(@"%@", error);
                                                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                                        NSLog(@"error :: %@", httpResponse);
                                                        resultado = [[ResultadoOperacionDTO alloc] init];
                                                        [resultado setSuccess : FALSE];
                                                        //[resultado setDescription:@"Servicio no disponible."];
                                                    }else {
                                                        NSError *error = nil;
                                                        id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
                                                        NSLog(@"json : %@", json);
                                                        if (json == nil) {
                                                            NSLog(@"%s: Error: %@", __PRETTY_FUNCTION__, [error localizedDescription]);
                                                            [resultado setSuccess:FALSE];
                                                        } else {
                                                            [resultado setSuccess:YES];
                                                            resultado = [self JSONToResultadoDTO:json];
                                                        }
                                                    }
                                                    handler(resultado);
                                                }];
    [dataTask resume];
}

+ (ResultadoOperacionDTO *)JSONToResultadoDTO:(NSDictionary *)json
{
    ResultadoOperacionDTO *resultado = [[ResultadoOperacionDTO alloc] init];
    [resultado setResults : json];
    if (json != NULL || json != nil) {
        [resultado setSuccess:YES];
    }
    
    return resultado;
}

@end
