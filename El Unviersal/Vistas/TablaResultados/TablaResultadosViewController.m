//
//  TablaResultadosViewController.m
//  Vista360
//
//  Created by Consultor on 28/10/16.
//  Copyright © 2016 Arturo Flores. All rights reserved.
//

#import "TablaResultadosViewController.h"
#import "Bean.h"

@interface TablaResultadosViewController ()
{
    IBOutlet UITableView *tablaDatos;
    NSMutableArray* array;
    UIActivityIndicatorView* activityIndicator;
}

@end

@implementation TablaResultadosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    array = [NSMutableArray new];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)reloadTableView {
    
    //parseamos la respuesta
    for (NSDictionary *objeto in _listaDatos){
        Bean *e = [[Bean alloc] setWithJSONDictionary:objeto];
        [array addObject:e];
    }
    
    [tablaDatos reloadData];
}

#pragma mark - UITableViewDataSource

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 166;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return  [array count];
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
    
}

-(RowTableViewCell *)configureCellNivel:(RowTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *nibObjects = [[NSBundle mainBundle] loadNibNamed:@"ProyectoTableViewCell" owner:self options:nil];
    cell = [nibObjects objectAtIndex:0];
    
    Bean* item = array[indexPath.row];
                  
    NSString* nameAll = [NSString stringWithFormat:@"%@ %@ %@",  item.namePerson,
                         item.lastName,
                         item.surname];
    
    [cell initData : nameAll
               rfc : item.rfc
        nacimiento : item.dateBirth];
    
    return cell;
}


#pragma mark - UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    // when reaching bottom, load a new page
    if (scrollView.contentOffset.y == scrollView.contentSize.height - scrollView.bounds.size.height)
    {
        [self setupTableViewFooter];
        
        if(_delegate){
            [_delegate tableToBottom];
        }
        
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
