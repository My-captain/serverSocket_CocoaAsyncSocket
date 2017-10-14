//
//  ViewController.m
//  socketChatClient
//
//  Created by Mr.Robot on 2017/10/14.
//  Copyright © 2017年 Mr.Robot. All rights reserved.
//

#import "ViewController.h"
#import "GCDAsyncSocket.h"

@interface ViewController ()<GCDAsyncSocketDelegate, UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITableView *messageTable;
@property (nonatomic, strong)GCDAsyncSocket *clientSocket;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    GCDAsyncSocket *clientSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_global_queue(0, 0)];
    self.clientSocket = clientSocket;
    
    NSError *error = nil;
    [clientSocket connectToHost:@"192.168.153.132" onPort:5288 error:&error];
}

- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port{
    NSLog(@"%@", sock);
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err{
    NSLog(@"%@", err);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 0;
}

- (IBAction)send:(id)sender {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end









