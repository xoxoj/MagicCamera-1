//
//  CameraUtil.swift
//  MagicCamera
//
//  Created by Akkey on 2015/12/24.
//  Copyright © 2015年 AkkeyLab. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class CameraUtil {
    
    class func imageFromSampleBuffer(sampleBuffer: CMSampleBufferRef) -> UIImage {
        let imageBuffer: CVImageBufferRef! = CMSampleBufferGetImageBuffer(sampleBuffer)
        
        CVPixelBufferLockBaseAddress(imageBuffer, 0)
        
        let baseAddress: UnsafeMutablePointer<Void> = CVPixelBufferGetBaseAddressOfPlane(imageBuffer, 0)
        
        let bytesPerRow: Int = CVPixelBufferGetBytesPerRow(imageBuffer)
        let width: Int = CVPixelBufferGetWidth(imageBuffer)
        let height: Int = CVPixelBufferGetHeight(imageBuffer)
        
        let colorSpace: CGColorSpaceRef! = CGColorSpaceCreateDeviceRGB()
        
        let bitsPerCompornent: Int = 8
        let bitmapInfo = CGBitmapInfo(rawValue: (CGBitmapInfo.ByteOrder32Little.rawValue | CGImageAlphaInfo.PremultipliedFirst.rawValue) as UInt32)
        let newContext: CGContextRef! = CGBitmapContextCreate(baseAddress, width, height, bitsPerCompornent, bytesPerRow, colorSpace, bitmapInfo.rawValue) as CGContextRef!
        
        let imageRef: CGImageRef! = CGBitmapContextCreateImage(newContext!)
        
        CVPixelBufferUnlockBaseAddress(imageBuffer, 0)

        let resultImage: UIImage = UIImage(CGImage: imageRef)
        
        return resultImage
    }

}