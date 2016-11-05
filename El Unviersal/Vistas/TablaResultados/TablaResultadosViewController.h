//
//  TablaResultadosViewController.h
//  Vista360
//
//  Created by Consultor on 28/10/16.
//  Copyright © 2016 Arturo Flores. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RowTableViewCell.h"    


@protocol tablaResultadosCellDelegate <NSObject>
-(void) tableToBottom;
@end

@interface TablaResultadosViewController : UIViewController

- (void)reloadTableView ;

@property (nonatomic, retain) id listaDatos; // obtenemos el dictionary de la vista anterior
@property (nonatomic, retain) id <tablaResultadosCellDelegate> delegate;

@end
