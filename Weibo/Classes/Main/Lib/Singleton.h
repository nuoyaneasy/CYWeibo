//实现单例设计模式

//.h文件的实现
#define SingletonH(methodName) +(instancetype)shared##methodName;

//.m文件的实现
#define SingletionM(methodName) \
static id _instance=nil;\
+ (id)allocWithZone:(struct NSZone *)zone\
{\
    if (_instance == nil) {\
        static dispatch_once_t onceToken;\
        dispatch_once(&onceToken, ^{\
        _instance = [super allocWithZone:zone];\
        });\
    }\
}\
- (id)init\
{\
    static dispatch_once_t onceToken;\
    dispatch_once(&onceToken, ^{\
        _instance = [super init];\
    });\
    return _instance;\
}\
+ (instancetype)shared##methodName\
{\
    return [[self alloc] init];\
}\
- (void)release\
{\
   \
}\
- (void)retain\
{\
    \
}\
- (NSUinteger)retainCount\
{\
    return 1;\
}\
