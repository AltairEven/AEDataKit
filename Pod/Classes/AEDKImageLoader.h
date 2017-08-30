//
//  AEDKImageLoader.h
//  Pods
//
//  Created by Altair on 29/08/2017.
//
//

#import <Foundation/Foundation.h>

typedef enum {
    AEDKImageLoadViaNoNet = 1 << 0,
    AEDKImageLoadVia2G = 1 << 1,
    AEDKImageLoadVia3G = 1 << 2,
    AEDKImageLoadVia4G = 1 << 3,
    AEDKImageLoadViaWifi = 1 << 4
}AEDKImageLoadStrategy;

NS_ASSUME_NONNULL_BEGIN

@interface AEDKImageLoader : NSObject

@property (nonatomic, assign) AEDKImageLoadStrategy loadStrategy;

@end

@interface AEDKImageLoader (UIImage)

+ (void)imageWithUrl:(NSURL * __nullable)url
            progress:(void(^ __nullable)(int64_t totalAmount, int64_t currentAmount))progress
           completed:(void(^ __nullable)(NSURL *__nullable imageUrl, UIImage *__nullable image, NSError *__nullable error))completedBlock;

@end

@interface AEDKImageLoader (UIImageView)

@property (nonatomic, strong) UIImage *defaultPlaceholderImage;

@property (nonatomic, assign) UIViewContentMode defaultContentMode; //默认UIViewContentModeScaleAspectFill

@property (nonatomic, assign) UIViewContentMode defaultPlaceholderContentMode; //默认UIViewContentModeScaleAspectFill

- (void)setImageForImageView:(UIImageView *)imageView
                     withUrl:(NSURL * __nullable)url;

- (void)setImageForImageView:(UIImageView *)imageView
                     withUrl:(NSURL * __nullable)url
            placeholderImage:(UIImage * __nullable)image;

- (void)setImageForImageView:(UIImageView *)imageView
                     withURL:(NSURL * __nullable)url
                   completed:(void(^ __nullable)(NSURL *__nullable imageUrl, UIImage *__nullable image, NSError *__nullable error))completedBlock;

- (void)setImageForImageView:(UIImageView *)imageView
                     withURL:(NSURL * __nullable)url
            placeholderImage:(UIImage * __nullable)image
                   completed:(void(^ __nullable)(NSURL *__nullable imageUrl, UIImage *__nullable image, NSError *__nullable error))completedBlock;

- (void)setImageForImageView:(UIImageView *)imageView
                     withURL:(NSURL * __nullable)url
                    progress:(void(^ __nullable)(int64_t totalAmount, int64_t currentAmount))progress
                   completed:(void(^ __nullable)(NSURL *__nullable imageUrl, UIImage *__nullable image, NSError *__nullable error))completedBlock;

- (void)setImageForImageView:(UIImageView *)imageView
                     withURL:(NSURL * __nullable)url
            placeholderImage:(UIImage * __nullable)placeholder
                    progress:(void(^ __nullable)(int64_t totalAmount, int64_t currentAmount))progress
                   completed:(void(^ __nullable)(NSURL *__nullable imageUrl, UIImage *__nullable image, NSError *__nullable error))completedBlock;

@end

NS_ASSUME_NONNULL_END
