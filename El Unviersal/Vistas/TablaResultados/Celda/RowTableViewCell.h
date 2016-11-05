//
//  ProyectoTableViewCell.h


#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

/*
@protocol proyectoCellDelegate <NSObject>
-(void)regresaTouch : (UILongPressGestureRecognizer *)gestrue;
@end
*/

@interface RowTableViewCell : UITableViewCell

-(void)initData  : (NSString*) titulo
     descripcion : (NSString*) descripcion
         seccion : (NSString*) seccion
           image : (NSString*) image
       thumbnail : (NSString*) thumbnail;

@property (nonatomic, retain) IBOutlet UILabel* lblTitulo;
@property (nonatomic, retain) IBOutlet UILabel* lblDescripcion;
@property (nonatomic, retain) IBOutlet UILabel* lblSeccion;
@property (nonatomic, retain) IBOutlet UIImageView* imageCell;


@end
