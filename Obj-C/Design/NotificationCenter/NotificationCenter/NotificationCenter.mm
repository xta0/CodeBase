//
//  NotificationCenter.m
//  NotificationCenter
//
//  Created by moxin on 12/12/18.
//  Copyright © 2018 Tao Xu. All rights reserved.
//

#import "NotificationCenter.h"
#import <libkern/OSAtomic.h>

typedef NS_ENUM(NSUInteger,NotificationType){
    block = 0,
    selector
};


@implementation Notification

+ (Notification* )newWithName:(NSString* )name Sender:(id)object ext: (NSDictionary* )userinfo{
    Notification* nt = [Notification new];
    nt.name = name;
    nt.object = object;
    nt.userInfo = userinfo;
    return nt;
}
@end

@interface Observation : NSObject{
@public
    __weak id _observer;
    SEL _selector;
    __strong NotificationCallback _block;
}

- (id)initWithObserver:(id)ob Selector:(SEL) sel Block:(NotificationCallback)blk;


@end

@implementation Observation

- (id)initWithObserver:(id)ob Selector:(SEL) sel Block:(NotificationCallback)blk{
    self = [super init];
    if(self){
        _observer = ob;
        _selector = sel;
        _block = [blk copy];
    }
    return self;
}

@end


@interface NotificationCenter();

@end

@implementation NotificationCenter{
    
    //key: string, value: observation
    NSMutableDictionary<NSString*, NSMutableSet<Observation* >* >* _table;
    NSRecursiveLock* _lock;
//    OSSpinLock _lock;
    
}
+ (instancetype)defaultCenter{
    static dispatch_once_t onceToken = 0;
    static NotificationCenter* instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [NotificationCenter new];
    });
    return instance;
}

- (instancetype)init{
    self = [super init];
    if(self){
//        _lock = OS_SPINLOCK_INIT;
        _lock = [NSRecursiveLock new];
        _table = [NSMutableDictionary new];
    }
    return self;
}

- (void)postNotificationName:(NSNotificationName)aName object:(nullable id)anObject userInfo:(nullable NSDictionary *)aUserInfo{
    
    NSParameterAssert(aName);
    
    Notification* nf = [Notification newWithName:aName Sender:anObject ext:aUserInfo];
    
    //lock
//    OSSpinLockLock(&_lock);
    [_lock lock];
    //get observation from TABLE
    NSMutableSet* sets = _table[aName];
    for(Observation* ob in sets){
        if(ob->_observer){
            if(ob->_selector){
                [ob->_observer performSelector:ob->_selector withObject:nf];
            }

            if(ob->_block){
                ob->_block(nf);
            }
        }
    }
//    OSSpinLockUnlock(&_lock);
    [_lock unlock];
    
}

- (void)addObserver:(id)observer ForName:(nullable NSNotificationName)name usingBlock:(NotificationCallback)block{
    
    NSParameterAssert(observer);
    NSParameterAssert(name);
    NSParameterAssert(block);
    
    [self _addObserver:observer selector:0 name:name usingBlock:block];
}

- (void)addObserver:(id)observer selector:(SEL)aSelector name:(NSString *)aName{
   
    NSParameterAssert(observer);
    NSParameterAssert(aSelector);
    NSParameterAssert(aName);
    if( ![observer respondsToSelector:aSelector]){
        [NSException raise:NSInvalidArgumentException format:@"Observer does not implement aSelector!"];
    }
    [self _addObserver:observer selector:aSelector name:aName usingBlock:nil];
}


- (void)removeObserver:(id)observer{
    NSParameterAssert(observer);
    return [self removeObserver:observer name:nil object:nil];
}
- (void)removeObserver:(id)observer name:(nullable NSNotificationName)aName object:(nullable id)anObject{
    
//    OSSpinLockLock(&_lock);
    [_lock lock];
    if(!aName){
        [_table removeObjectForKey:aName];
    }else{
        Observation* ob = nil;
        for(Observation* o in _table[aName] ){
            if(o->_observer ==observer){
                ob = o;
                break;
            }
        }
        if(ob){
            [_table[aName] removeObject:ob];
        
        }
    }
    [_lock unlock];
//    OSSpinLockUnlock(&_lock);
}

#pragma mark - private methods

- (void)_addObserver:(id)observer selector:(SEL)aSelector name:(NSString *)aName usingBlock:(NotificationCallback) blk{

    Observation* ob = [[Observation alloc]initWithObserver:observer Selector:aSelector Block:blk];
    //lock table
//    OSSpinLockLock(&_lock);
    [_lock lock];
    NSMutableSet* set = _table[aName];
    if(!set){
        set = [NSMutableSet new];
    }
    [set addObject:ob];
    _table[aName] = set;
//    OSSpinLockUnlock(&_lock);
    [_lock unlock];
    
}

@end
