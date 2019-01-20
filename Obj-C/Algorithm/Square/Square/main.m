#import <Foundation/Foundation.h>
#import <stdio.h>



/*
 
 A -->middle --> B
 
 
 device ---> A ------ B
 
 */
@interface Packet:NSObject

@property(strong,nonatomic,readonly) NSString* content;
- (id)initWithContent:(NSString* )content;

@end

@implementation Packet

- (id)initWithContent:(NSString* )content{
    self = [super init];
    if(self){
        _content = content;
    }
    return self;
}

- (NSString* )description{
    return self.content;
}
@end





@interface Router:NSObject
@property(strong,nonatomic,readonly) NSString* name;

- (id)initWithName:(NSString* )name;
- (void)sendPacket:(Packet* ) packet to:(Router* )router;
- (void)recvPacket:(Packet* ) packet from:(Router* )router;
@end

@implementation Router{
    NSMutableArray<Packet* >* _messages;
}
- (id)initWithName:(NSString* )name{
    self = [super init];
    if(self){
        _name = name;
        _messages = [NSMutableArray new];
    }
    return self;
}

/*
 routerName: class name of the router
 */
- (void)sendPacket:(Packet* ) packet withRouterName:(NSString* )routerName{
    Router* router = [[Router alloc]initWithName:routerName];
    [self sendPacket:packet to:router];
}
- (void)sendPacket:(Packet* ) pack to:(Router* )router{
    
    [router recvPacket:pack from: self];
    
}
- (void)recvPacket:(Packet* ) packet from:(Router* )router{
    [_messages addObject:packet];
    NSLog(@"messages:%@",_messages);
    for(Packet* p in _messages){
        NSLog(@"%@ received message from %@ with contents: %@",self.name,router.name,p);
    }
    
    
}
@end

@interface PacketCenter:NSObject
+ (id)sharedInstance;
- (void)sendTo:(NSString* )routerName withPacket:(Packet* )packet from:(Router* )r;
@end

@implementation PacketCenter{
    NSMutableDictionary<NSString*, Router* >* _map;
}

+ (id)sharedInstance{
    static dispatch_once_t onceToken;
    static PacketCenter* instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [PacketCenter new];
    });
    return instance;
}

- (id)init{
    self = [super init];
    if(self){
        _map = [NSMutableDictionary<NSString*, Router* > new];
    }
    return self;
    
}
- (void)sendTo:(NSString* )routerName withPacket:(Packet* )packet from:(Router* )r{
    Router* router = _map[routerName];
    if(router){
        [router recvPacket:packet from:r];
        
    }else{
        Router* router = [[Router alloc]initWithName:routerName];
        [router recvPacket:packet from:r];
        _map[routerName] = router;
    }
    
    
}
@end


int main (int argc, const char * argv[])
{
    // RouterB: received message from 'RouterA' with contents: 'Hello!'
    
    @autoreleasepool {
        
        Router* routerA = [[Router alloc]initWithName:@"RouterA"];
        // Router* routerB = [[Router alloc]initWithName:@"RouterB"];
        Packet* packet1 = [[Packet alloc]initWithContent:@"Hello"];
        Packet* packet2 = [[Packet alloc]initWithContent:@"World"];
        // [PacketCenter send:routerA withPacket:packet from: routerB];
        
        //
        // routerA.send('routerB', 'Hello');
        [[PacketCenter sharedInstance] sendTo:@"routerB" withPacket:packet1 from:routerA];
        [[PacketCenter sharedInstance] sendTo:@"routerB" withPacket:packet2 from:routerA];
        // [routerA sendPacket:packet1 withRouterName:@"routerB"];
        // [routerA sendPacket:packet2 withRouterName:@"routerB"];
        
        // 'Hello'
        // 'World'
        
        
        // routerB received message from routerA messsages: 'hello'
        // routerB received message from routerA messages: 'hello' 'world'
    }
}
