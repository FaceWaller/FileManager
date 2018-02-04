//
//  FileBaseCell.m
//  FileManager
//
//  Created by Alan on 2018/1/26.
//  Copyright © 2018年 Alan. All rights reserved.
//

#import "FileBaseCell.h"

@interface FileBaseCell()
@property(nonatomic,weak)UIImageView * iconView;
@property(nonatomic,weak)UILabel * titleLabel;
@property(nonatomic,weak)UIView * lineView;
@property(nonatomic,assign)FileType fileType;
@end
@implementation FileBaseCell

- (UIImageView *)iconView{
    if (!_iconView) {
        UIImageView * iconView = [[UIImageView alloc]init];
        _iconView = iconView;
        [self.contentView addSubview:_iconView];
        
    }
    return _iconView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        UILabel * titleLabel = [[UILabel alloc]init];
        _titleLabel = titleLabel;
        [self.contentView addSubview:titleLabel];
    }
    return _titleLabel;
}

- (UIView *)lineView{
    if (!_lineView) {
        UIView * lineView = [[UIView alloc]init];
        _lineView = lineView;
        [self.contentView addSubview:lineView];
        _lineView.backgroundColor = [UIColor hexChangeFloat:@"E5E5E5"];
    }
    return _lineView;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUpUI];
        
    }
    return self;
}



- (void)setUpUI{
    [self.iconView autoSetDimension:ALDimensionWidth toSize:40];
    [self.iconView autoSetDimension:ALDimensionHeight toSize:40];
    [self.iconView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [self.iconView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];

    [self.titleLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.iconView withOffset:15];
    [self.titleLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
    [self.titleLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    
    
    [self.lineView autoSetDimension:ALDimensionHeight toSize:1];
    [self.lineView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.titleLabel];
    [self.lineView autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [self.lineView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    

}

- (void)setFileUrl:(NSURL *)fileUrl{
    _fileUrl = fileUrl;
    
    //获取名字
    NSString * str = [FileTool getUrlValue:fileUrl withResourceKey:NSURLNameKey];
    self.titleLabel.text = str;
    
    
    [self setImageIconWithFileUrl:fileUrl];
    
}

- (void)setImageIconWithFileUrl:(NSURL *)fileUrl
{
    NSString * filePath = [fileUrl path];
    self.fileType = [FileTool getFileTypeWithPath:filePath];

    UIImage * image;
    switch (self.fileType) {
        case NONETYPE: //不识别的类型
            image = [UIImage imageNamed:@"noneIcon"];
            break;
        case FOLDERTYPE: //文件夹类型
            image = [UIImage imageNamed:@"folderIcon"];
            break;
        case TEXTTYPE:   //文本类型
            image = [UIImage imageNamed:@"textIcon"];
            break;
        case IMAGETYPE:  //图片类型
            image = [FileTool getThumbnailWithUrl:fileUrl];
//            [UIImage imageNamed:@"imageIcon"];
            break;
        case AUDIOTYPE:  //音频类型
            image = [UIImage imageNamed:@"audioIcon"];
            break;
        case MOVIETYPE:  //视频类型
            image = [UIImage imageNamed:@"movieIcon"];
            break;
        case PDFTYPE:    //PDF类型
            image = [UIImage imageNamed:@"pdfIcon"];
            break;
        default:
            break;
    }
    
    self.iconView.image = image;
    
}

@end
