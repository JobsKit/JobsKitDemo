//UIView转UIImage
+ (UIImage *)getImageFromView:(UIView *)view{

UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, [UIScreen mainScreen].scale);

[view.layer renderInContext:UIGraphicsGetCurrentContext()];

UIImage *image = UIGraphicsGetImageFromCurrentImageContext();

UIGraphicsEndImageContext();

return image;
}

//旋转
+(void)setTransform:(float)radians
forView:(UIView *)view{

view.transform = CGAffineTransformMakeRotation(M_PI * radians);

//    使用:例如逆时针旋转40度
//    [setTransform:40/180 forLable:label]
}

/*
*  1、子视图超出父视图，超出部分裁剪掉;
*  2、使用的时候必须先给WaterMark的子类一个frame;
*/

//使用示例:见ViewController@3
