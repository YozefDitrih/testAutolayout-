//
//  TableViewController.m
//  testAutolayout
//
//  Created by Антон Погремушкин on 10.02.17.
//  Copyright © 2017 Антон Погремушкин. All rights reserved.
//

#import "TableViewController.h"
#import "Link.h"
#import "DataBase.h"
#import "AddViewController.h"
#import "WebViewController.h"
#import <Masonry.h>

@interface TableViewController ()

@property (retain, nonatomic) NSMutableArray *links;
@property (readwrite) AddViewController *addViewController;
@property (readwrite) WebViewController *webViewController;
@property (nonatomic,strong) MASConstraint *topConstraint;

@end

@implementation TableViewController

-(id)init{
    if (self = [super init]){
        [self.view setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.links = [[DataBase shared] getLinksArray];
    
    UIBarButtonItem *edit =[[UIBarButtonItem alloc]
                             initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                             target:self
                             action:@selector(editing)];
    self.navigationItem.rightBarButtonItem = edit;
    
    UIBarButtonItem *add = [[UIBarButtonItem alloc]
                            initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                            target:self
                            action:@selector(addItem)];
    self.navigationItem.leftBarButtonItem = add;

    
}


#pragma mark - editing
- (void)editing
{
    [self.tableView setEditing:!self.tableView.editing animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    Link *link = self.links[indexPath.row];
    NSLog(@"%@", link.name);
    
    DataBase *data = [[DataBase alloc] init];
    [data deleteInDataBase:link];
    [self.links removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                     withRowAnimation:UITableViewRowAnimationFade];
    
}

- (void)addItem
{
    if(_addViewController){
        self.addViewController = nil;
    }
    AddViewController *addView = [[AddViewController alloc] init];
    self.addViewController = addView;
    
    [self.addViewController setDelegate:self];
    [self.navigationController pushViewController:self.addViewController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)controller:(AddViewController *)controller didSaveItemWithName:(NSString *)name andURL:(NSURL *)URL{
    Link *link = [Link linkWithUrlAndName:name andURL:URL];
    [self.links addObject:link];
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForItem:([self.links count] - 1) inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationNone];
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.links.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Link *link = self.links[indexPath.row];
    
    static NSString *CellIdentifier = @"Cell Identifier";
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    [cell.textLabel setText:link.name];
    
    
    return cell;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    if (section == 0)
//    {
//        return 30.0f;
//    }
//    return 20.0f;
//    // высота заголовка
//    // section позволяет выбрать для какого именно с помощью уловного опер rатора
//}

// переход на веб
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(_webViewController){
        self.webViewController = nil;
    }
    
    WebViewController *addView = [[WebViewController alloc] init];
    self.webViewController = addView;
    
    [self.addViewController setDelegate:self];
    Link *link = self.links[indexPath.row];
    self.webViewController.URL = link.URL;
    [self.navigationController pushViewController:self.webViewController animated:YES];
}






@end
