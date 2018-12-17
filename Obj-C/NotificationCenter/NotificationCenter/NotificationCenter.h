//
//  NotificationCenter.h
//  NotificationCenter
//
//  Created by moxin on 12/12/18.
//  Copyright © 2018 Tao Xu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN



@interface Notification : NSObject
@property(nonatomic,strong) NSString* name;
@property(nonatomic,weak) id object;
@property(nonatomic,strong) NSDictionary* userInfo;

+ (Notification* )newWithName:(NSString* )name Sender:(id)object ext: (NSDictionary* )userinfo;
@end

typedef void(^NotificationCallback)(Notification*);

@interface NotificationCenter : NSObject

+ (instancetype)defaultCenter;

- (void)postNotificationName:(NSNotificationName)aName object:(nullable id)anObject userInfo:(nullable NSDictionary *)aUserInfo;



- (void)addObserver:(id)observer selector:(SEL)aSelector name:(NSString* )aName;
- (void)addObserver:(id)observer ForName:(nullable NSNotificationName)name usingBlock:(NotificationCallback)block;

- (void)removeObserver:(id)observer;
- (void)removeObserver:(id)observer name:(nullable NSNotificationName)aName object:(nullable id)anObject;


@end

NS_ASSUME_NONNULL_END
