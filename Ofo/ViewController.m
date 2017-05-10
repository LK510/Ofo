//
//  ViewController.m
//  Ofo
//
//  Created by 路飞 on 2017/2/28.
//  Copyright © 2017年 路飞. All rights reserved.
//

#define screenWidth [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height

#import "ViewController.h"
#import "NSObject+Message.h"
#import "Model.h"
#import "FMDB.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *bikeNum;
@property (weak, nonatomic) IBOutlet UITextField *bikePwd;

@property (weak, nonatomic) IBOutlet UIButton *setBtn;
@property (weak, nonatomic) IBOutlet UIButton *getBtn;

@property (nonatomic,strong) FMDatabase *db;

@end

@implementation ViewController

- (IBAction)setClick:(id)sender {

    if (self.bikeNum.text!=nil&&![self.bikeNum.text isEqualToString:@""]&&self.bikePwd.text!=nil&&![self.bikePwd.text isEqualToString:@""]) {
        
        //dataBase
        [self.db executeUpdate:@"INSERT INTO t_bike (bikenum, bikepwd) VALUES (?,?);",self.bikeNum.text,self.bikePwd.text];
        

        
        //userDefault
        NSString* dataString = [[NSUserDefaults standardUserDefaults] objectForKey:@"bike"];
        
        id shortCutDic = nil;
        if (dataString==nil || [dataString isEqualToString:@""]) {
            shortCutDic = [[NSMutableDictionary alloc] init];
        }else{
            
            NSData* jsonData = [dataString dataUsingEncoding:NSUTF8StringEncoding];
            NSError *error = nil;
            shortCutDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
        }
        
        Model *newModel = [[Model alloc] init];
        newModel.num = self.bikeNum.text;
        newModel.pwd = self.bikePwd.text;
    
        NSMutableDictionary *mutDic = [newModel getDictionary];
        
        [shortCutDic setValue:mutDic forKey:self.bikeNum.text];
        
        NSError *error = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:shortCutDic
                                                           options:0
                                                             error:&error];
        NSString* shortCutJsonString =  [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        
        //保存快捷列表到default
        [[NSUserDefaults standardUserDefaults] setValue:shortCutJsonString forKey:@"bike"];
        
        self.bikeNum.text = nil;
        self.bikePwd.text = nil;
        [self.view endEditing:YES];
        [[self showMessage:@"存储成功！"] contetHeight:screenWidth];
        
    }else{
    
        [[self showMessage:@"输入框不能为空！！！"] contetHeight:screenWidth];
    }
    
}

- (IBAction)getClick:(id)sender {
    
    if (self.bikeNum.text!=nil&&![self.bikeNum.text isEqualToString:@""]) {
        
        NSString* shortCutDicString = [[NSUserDefaults standardUserDefaults] objectForKey:@"bike"];
        
        id shortCutDic = nil;
        if (shortCutDicString==nil || [shortCutDicString isEqualToString:@""]) {
            [[self showMessage:@"数据库为空！！！"] contetHeight:screenWidth];
        }else{
            
            NSData* jsonData = [shortCutDicString dataUsingEncoding:NSUTF8StringEncoding];
            NSError *error = nil;
            shortCutDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
        }
        if (shortCutDic!=nil && [shortCutDic isKindOfClass:[NSDictionary class]]) {
            
            NSDictionary *shortCut = [shortCutDic valueForKey:self.bikeNum.text];
            
            self.bikePwd.text = [shortCut valueForKey:@"bikepwd"];
            
//            if (shortCut!=nil && [shortCut isKindOfClass:[NSArray class]]) {
//                
//                if ([shortCut.allKeys containsObject:self.bikeNum.text]) {
//                    NSString *pwdStr = [shortCut valueForKey:self.bikeNum.text];
//                    self.bikePwd.text = pwdStr;
//                }
//            }
        }
        
        FMResultSet *resultSet = [self.db executeQuery:@"select * from t_bike;"];
        
        //遍历结果集合
        
        while ([resultSet  next])
        {
            NSString *bikeNum = [resultSet stringForColumn:@"bikenum"];
            
            if ([bikeNum isEqualToString:self.bikeNum.text]) {
                self.bikePwd.text = [resultSet stringForColumn:@"bikepwd"];
            }
            
        }
        
    }else{
        
        [[self showMessage:@"bike车牌号不能为空！！！"] contetHeight:screenWidth];
    }

}

- (void) createDb{

    //1.获得数据库文件的路径
    NSString *doc =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)  lastObject];
    
    NSString *fileName = [doc stringByAppendingPathComponent:@"student.sqlite"];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    
    if (![manager fileExistsAtPath:fileName]) {
    
        //2.获得数据库
        FMDatabase *db = [FMDatabase databaseWithPath:fileName];
        self.db = db;
        //3.使用如下语句，如果打开失败，可能是权限不足或者资源不足。通常打开完操作操作后，需要调用 close 方法来关闭数据库。在和数据库交互 之前，数据库必须是打开的。如果资源或权限不足无法打开或创建数据库，都会导致打开失败。
        if ([db open])
        {
            //4.创表
//            BOOL result = [db executeUpdate:@"create table if not exists stu(name text)"];

//            BOOL result = [db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_bike (\
                           bike_id INTEGER，\
                           bikenum TEXT,\
                           bikepwd TEXT,\
                           primary key(bike_id)\
                           )"];
            
            BOOL result = [db executeUpdate:@"CREATE TABLE if not exists t_bike(\
             data_id TEXT,\
             book_id TEXT,\
             data_title TEXT,\
             data_content TEXT,\
             primary key(data_id)\
             )"];

            
            if (![db columnExists:@"bikepwd " inTableWithName:@"t_bike"]){
                
                NSString *alertStr = [NSString stringWithFormat:@"ALTER TABLE %@ ADD %@ INTEGER",@"t_bike",@"bikepwd"];
                BOOL worked = [db executeUpdate:alertStr];
                if(worked){
                    NSLog(@"插入成功");
                }else{
                    NSLog(@"插入失败");
                }
            }
            
            
            if (result)
            {
                NSLog(@"创建表成功");
            }
        }

    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self createDb];
}

- (void) setup{

    self.setBtn.layer.cornerRadius = 10;
    self.getBtn.layer.cornerRadius = 10;
    
    [self.setBtn setClipsToBounds:YES];
    [self.getBtn setClipsToBounds:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
