//
//  ResultadoOperacionDTO.h

#import <Foundation/Foundation.h>

@interface Bean : NSObject

@property (nonatomic, retain) NSString* titulo;
@property (nonatomic, retain) NSString* descripcion;
@property (nonatomic, retain) NSString* body;
@property (nonatomic, retain) NSString* seccion;
@property (nonatomic, retain) NSString* image;
@property (nonatomic, retain) NSString* thumbnail;



- (id)setWithJSONDictionary:(NSDictionary *)aDictionary;
@end
