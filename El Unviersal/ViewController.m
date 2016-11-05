//
//  ViewController.m
//  El Unviersal
//
//  Created by Consultor on 05/11/16.
//  Copyright © 2016 Arturo Flores. All rights reserved.
//

#import "ViewController.h"
#import "Services.h"
#import "Bean.h"
#import "UIImageView+WebCache.h"
#import "DetalleViewController.h"

@interface ViewController () 
{
    IBOutlet UITableView *tablaDatos;
    NSMutableArray* arrayNotas;
    UIActivityIndicatorView* activityIndicator;
    int paginaAux;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Noticias mas recientes";
    arrayNotas = [NSMutableArray new];
    paginaAux = 0;
    [self getNotas];
}

-(void)getNotas {
    [Services getNotasElUniversal : paginaAux
                         complete : ^(ResultadoOperacionDTO *resultado) {
                             
                             if (resultado.success) {
                                 dispatch_async(dispatch_get_main_queue(), ^{
                                     // enviamos el resultado, y recargamos la tabla
                                     [self reloadTableView : resultado.results];
                                     paginaAux += 1;
                                 });
                             }
                         }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)reloadTableView : (id)resultado{
    
    //parseamos la respuesta
    for (NSDictionary *objeto in resultado){
        Bean *e = [[Bean alloc] setWithJSONDictionary:objeto];
        [arrayNotas addObject:e];
    }
    
    [tablaDatos reloadData];
}


#pragma mark - UITableViewDataSource

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 136;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return  [arrayNotas count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    static NSString *CellIdentifier = @"CustomCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell = (RowTableViewCell*)[tablaDatos dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [self configureCellNivel:(RowTableViewCell*)cell atIndexPath:indexPath];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;//UITableViewCellSelectionStyleNone;
    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetalleViewController *detalle = (DetalleViewController *)[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"detalle"];
    detalle.bean = arrayNotas[indexPath.row];
    [self.navigationController pushViewController:detalle animated:YES];
}

-(RowTableViewCell *)configureCellNivel:(RowTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *nibObjects = [[NSBundle mainBundle] loadNibNamed:@"ProyectoTableViewCell" owner:self options:nil];
    cell = [nibObjects objectAtIndex:0];
    
    Bean* item = arrayNotas[indexPath.row];
    
    [cell initData : item.titulo
       descripcion : item.descripcion
           seccion : item.seccion
             image : item.image
         thumbnail : item.thumbnail];
    
    return cell;
}


#pragma mark - UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    // when reaching bottom, load a new page
    if (scrollView.contentOffset.y == scrollView.contentSize.height - scrollView.bounds.size.height)
    {
        [self setupTableViewFooter];
        [self getNotas];
    }
}

- (void)setupTableViewFooter
{
    // set up label
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    footerView.backgroundColor = [UIColor clearColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textColor = [UIColor lightGrayColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"Descargando datos ...";
    
    //self.footerLabel = label;
    [footerView addSubview:label];
    
    // set up activity indicator
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicatorView.center = CGPointMake(40, 22);
    activityIndicatorView.hidesWhenStopped = YES;
    
    [activityIndicatorView startAnimating];
    [footerView addSubview:activityIndicatorView];
    
    tablaDatos.tableFooterView = footerView;
    
    [self scrollToBottom];
}

- (void)scrollToBottom
{
    CGFloat yOffset = 0;
    
    if (tablaDatos.contentSize.height > tablaDatos.bounds.size.height) {
        yOffset = tablaDatos.contentSize.height - tablaDatos.bounds.size.height;
    }
    
    [tablaDatos setContentOffset:CGPointMake(0, yOffset) animated:NO];
}






@end
