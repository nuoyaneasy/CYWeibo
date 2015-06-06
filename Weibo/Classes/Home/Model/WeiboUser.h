//
//  WeiboUser.h
//  Weibo
//
//  Created by Yang Chao on 6/2/15.
//  Copyright (c) 2015 Self. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    WeiboUserVerifiedTypeNone = -1,  //没有任何认证
    
    WeiboUserVerifiedTypePersonal = 0, //个人
    
    WeiboUserVerifiedTypeOrgEnterprize = 2,
    WeiboUserVerifiedTypeOrgMedia = 3,
    WeiboUserVerifiedTypeOrgWebsite = 5,
    
    WeiboUserVerifiedTypeDaren = 220 //达人
    
}WeiboUserVerifiedType;

@interface WeiboUser : NSObject

/**idstr	string	字符串型的用户UID*/
@property (nonatomic, copy) NSString *idstr;

/**	string	友好显示名称*/
@property (nonatomic, copy) NSString *name;

/** profile_image_url	string	用户头像地址（中图），50×50像素*/
@property (nonatomic, copy) NSString *profile_image_url;

/**mbtype  会员类型 > 2 代表是会员*/
@property (nonatomic, assign) int mbtype;

/** mbrank 会员等级*/
@property (nonatomic, assign) int mbrank;

@property (nonatomic, assign, getter=isVIP) BOOL VIP;

@property (nonatomic, assign) WeiboUserVerifiedType verified_type;


@end
