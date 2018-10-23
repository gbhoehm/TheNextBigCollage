//
//  CollectionViewCell.h
//  TheNextBigCollage
//
//  Created by Marlene Maier on 10/23/18.
//  Copyright © 2018 Concordia Software Class. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *images;
@property (weak, nonatomic) IBOutlet UILabel *cellTitle;

@end

NS_ASSUME_NONNULL_END
