//
//  DetalleViewController.m
//  El Unviersal
//
//  Created by Consultor on 05/11/16.
//  Copyright © 2016 Arturo Flores. All rights reserved.
//

#import "DetalleViewController.h"
#import "UIImageView+WebCache.h"

@interface DetalleViewController ()
{
    IBOutlet UIImageView* imagen;
    IBOutlet UILabel* titulo;
    IBOutlet UILabel* descripcion;
}

@end

@implementation DetalleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    titulo.text = _bean.titulo;
    descripcion.text = _bean.body;
    [imagen sd_setImageWithURL : [NSURL URLWithString: _bean.image]
                  placeholderImage : [UIImage imageNamed:@"splash"]];
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Compartir" style:UIBarButtonItemStylePlain target:self action:@selector(shared)];
    self.navigationItem.rightBarButtonItem = anotherButton;
    
}

-(void) shared {
    UIActionSheet* perfil = [[UIActionSheet alloc]initWithTitle:@"Compartir Noticia"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancelar"
                                         destructiveButtonTitle:nil
                             
                                              otherButtonTitles:@"Faceboook", @"WhatsApp", nil];
    
    perfil.tag = 100;
    [perfil showInView:self.view];
}

-(void) sendWhatsApp {
    
    NSString * msg = @"YOUR MSG";
    NSString * urlWhats = [NSString stringWithFormat:@"whatsapp://send?text=%@",msg];
    NSURL * whatsappURL = [NSURL URLWithString:[urlWhats stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    if ([[UIApplication sharedApplication] canOpenURL: whatsappURL]) {
        [[UIApplication sharedApplication] openURL: whatsappURL];
    } else {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Aviso" message:@"Tu dispositivo no tiene instalado la aplicación WhatsApp, para poder hacer uso de esta app, descárgala desde el App Store" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark delegado action sheet

- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (popup.tag) {
        case 100: {
            switch (buttonIndex) {
                case 0:
                    NSLog(@"0");
                    break;
                case 1:
                    [self sendWhatsApp];
                    break;
                case 2:

                    NSLog(@"2");
                    break;
                default:
                    break;
            }
            break;
        }
        default:
            break;
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
