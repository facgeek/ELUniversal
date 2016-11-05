//
//  ResultadoOperacionDTO.m


#import "Bean.h"
#import "PSStorageRoom.h"

@implementation Bean

@synthesize titulo;
@synthesize descripcion;
@synthesize body;
@synthesize seccion;
@synthesize image;
@synthesize thumbnail;



-(id)setWithJSONDictionary:(NSDictionary *)aDictionary{
    
    self.titulo = NilOrValue([aDictionary objectForKey:@"title"]);
    self.descripcion = NilOrValue([aDictionary objectForKey:@"summary"]);
    self.body = NilOrValue([aDictionary objectForKey:@"body"]);
    self.seccion = NilOrValue([aDictionary objectForKey:@"section"]);
    self.image = NilOrValue([aDictionary objectForKey:@"image"]);
    self.thumbnail = NilOrValue([aDictionary objectForKey:@"thumbnail"]);
    
    return self;
}

@end
