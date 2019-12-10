//
//  DriverInfoView.m
//  FBSnapshotTestCase
//
//  Created by ssp on 2019/12/9.
//

#import "DriverInfoView.h"
#import "Masonry.h"
@interface DriverInfoView()
@property(nonatomic,strong)UIButton *leftBtn;
@property(nonatomic,strong)UILabel *numberLab;
@property(nonatomic,strong)UILabel *iDCardLab;
@property(nonatomic,strong)UILabel *companyLab;
@property(nonatomic,strong)UILabel *nameLab;
@property(nonatomic,strong)UILabel *phoneLab;
@property(nonatomic,strong)UILabel *stateLab;
@property(nonatomic,strong)UIButton *operateBtn;
@end
@implementation DriverInfoView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
-(void)initUI{
    [self addSubview:self.leftBtn];
    [self addSubview:self.numberLab];
    [self addSubview:self.iDCardLab];
    [self addSubview:self.companyLab];
    [self addSubview:self.nameLab];
    [self addSubview:self.phoneLab];
    [self addSubview:self.stateLab];
    [self addSubview:self.operateBtn];
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    
    
}
#pragma mark - lazy
-(UIButton *)leftBtn{
    if (!_leftBtn) {
        _leftBtn=[[UIButton alloc] init];
        _leftBtn.backgroundColor=[UIColor grayColor];
    }
    return _leftBtn;
}
-(UIButton *)operateBtn{
    if (!_operateBtn) {
        _operateBtn=[[UIButton alloc] init];
        _operateBtn.backgroundColor=[UIColor grayColor];
    }
    return _operateBtn;
}
-(UILabel *)numberLab{
    if (!_numberLab) {
        _numberLab=[[UILabel alloc] init];
        _numberLab.backgroundColor=[UIColor grayColor];
    }
    return _numberLab;
}
-(UILabel *)iDCardLab{
    if (!_iDCardLab) {
        _iDCardLab=[[UILabel alloc] init];
        _iDCardLab.backgroundColor=[UIColor grayColor];
    }
    return _iDCardLab;
}
-(UILabel *)companyLab{
    if (!_companyLab) {
        _companyLab=[[UILabel alloc] init];
        _companyLab.backgroundColor=[UIColor grayColor];
    }
    return _companyLab;
}
-(UILabel *)nameLab{
    if (!_nameLab) {
        _nameLab=[[UILabel alloc] init];
        _nameLab.backgroundColor=[UIColor grayColor];
    }
    return _nameLab;
}
-(UILabel *)phoneLab{
    if (!_phoneLab) {
        _phoneLab=[[UILabel alloc] init];
        _phoneLab.backgroundColor=[UIColor grayColor];
    }
    return _phoneLab;
}
-(UILabel *)stateLab{
    if (!_stateLab) {
        _stateLab=[[UILabel alloc] init];
        _stateLab.backgroundColor=[UIColor grayColor];
    }
    return _stateLab;
}

@end
