//
//  ViewController.m
//  YoustitiAppObjC
//
//  Created by Youstiti on 23/07/2018.
//  Copyright © 2018 Youstiti. All rights reserved.
//

#import "ViewController.h"
#import "GCDAsyncSocket.h" // TCP
#import "GCDAsyncUdpSocket.h" // UDP


#define  WWW_PORT 443
#define  WWW_HOST @"espaceclient.youstiti.com"

@interface ViewController ()

@end

@implementation ViewController


- (IBAction)connectButton:(id)sender {

    GCDAsyncSocket* socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    
    NSLog(@"init fait\n");
    
    NSError *err = nil;
    
    NSLog(@"tentative connexion\n");
    if (![socket connectToHost:@"webservice.youstiti.com" onPort:20001 error:&err]) // Asynchronous!
    {
        NSLog(@"erreur connexion\n");
        // If there was an error, it's likely something like "already connected" or "no delegate set"
        NSLog(@"I goofed: %@", err);
    }
    NSLog(@"connect\n");
    
    char *bytes = "abcdefg";
    NSData* data = [[NSData alloc] initWithBytes:bytes length:sizeof(bytes)];
    
    //NSString *msg = @"xxxxx\r\n";
    //NSData *data = [msg dataUsingEncoding:NSUTF8StringEncoding];
    
    
    [socket writeData:data withTimeout:-1 tag:0];
    [data release];
}


- (void)socket:(GCDAsyncSocket *)sender didConnectToHost:(NSString *)host port:(UInt16)port
{
    NSLog(@"I'm connected !\n");
}

- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    if (tag == 0) {
        NSLog(@"Request sent");
    }
    else
        NSLog(@"no tag");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
