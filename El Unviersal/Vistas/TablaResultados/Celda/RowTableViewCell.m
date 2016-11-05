//
//  ProyectoTableViewCell.m

#import "RowTableViewCell.h"
#import "UIImageView+WebCache.h"



@implementation RowTableViewCell
/*
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
*/

-(void)initData  : (NSString*) titulo
     descripcion : (NSString*) descripcion
         seccion : (NSString*) seccion
           image : (NSString*) image
       thumbnail : (NSString*) thumbnail {
    
    _lblTitulo.text = titulo;
    _lblDescripcion.text = descripcion;
    _lblSeccion.text = seccion;
    
    [_imageCell sd_setImageWithURL : [NSURL URLWithString: image]
              placeholderImage : [UIImage imageNamed:@"thumbnail"]];
    
}


@end
