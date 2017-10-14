//
//  MRServiceListener.m
//  10086_socket
//
//  Created by Mr.Robot on 2017/10/14.
//  Copyright © 2017年 Mr.Robot. All rights reserved.
//

#import "MRServiceListener.h"
#import "TCP/GCDAsyncSocket.h"

@interface MRServiceListener()<GCDAsyncSocketDelegate>

@property (nonatomic, strong) GCDAsyncSocket *serverSocket;
@property (nonatomic, strong) NSMutableArray *clientSockets;

@end

@implementation MRServiceListener

- (NSMutableArray *)clientSockets {
    if (!_clientSockets) {
        _clientSockets = [NSMutableArray array];
    }
    return _clientSockets;
}

- (void)start{
    GCDAsyncSocket *serverSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_global_queue(0, 0)];
    self.serverSocket = serverSocket;
    NSError *error = nil;
    [serverSocket acceptOnPort:5288 error:&error];
    if (!error) {
        NSLog(@"10086服务开启成功");
    } else {
        NSLog(@"10086服务开启失败 %@", error);
    }
    self.serverSocket = serverSocket;
}

#pragma mark 有客户端的socket请求连接
- (void)socket:(GCDAsyncSocket *)serverSocket didAcceptNewSocket:(GCDAsyncSocket *)clientSocket {
    NSLog(@"serverSocket:    %@", serverSocket);
    NSLog(@"clientSocket:    %@ host:%@ port:%d", clientSocket, clientSocket.connectedHost, clientSocket.connectedPort);
    [self.clientSockets addObject:clientSocket];
    // 监听客户端是否有数据上传、timeout -1表示不超时、  tag起标识作用
    // 如果有数据就自动调用didReadData
    [clientSocket readDataWithTimeout:-1 tag:0];
}

- (void)socket:(GCDAsyncSocket *)clientSocket didReadData:(NSData *)data withTag:(long)tag {
    NSLog(@"读取数据 clientSocket %@", clientSocket);
//    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    for (GCDAsyncSocket *socket in self.clientSockets) {
        if (socket == clientSocket) continue;
        [socket writeData:data withTimeout:-1 tag:0];
    }
    
//    [clientSocket writeData:[string dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:0];

    // 每次读取完数据后、都要调用一次监听数据的方法
    [clientSocket readDataWithTimeout:-1 tag:0];
}

@end







