//
//  main.swift
//  ColorCube
//
//  Created by Eugenijus Margalikas on 18/11/2016.
//  Copyright © 2016 Eugenijus Margalikas. All rights reserved.
//
import Foundation
import CoreGraphics

let srcUrl = URL(fileURLWithPath:/*"/Users/Eugenijus/Documents/play_test/MyPlayground.playground/Resources/DSC01753.png"*/"/Users/Eugenijus/Documents/MATLAB/kartinki/test/fruits.png")

let imgSrc = CGImageSourceCreateWithURL( srcUrl as CFURL, nil)

let cgImage = CGImageSourceCreateImageAtIndex(imgSrc!, 0, nil)!


let width = cgImage.width
let height = cgImage.height
let bpp = cgImage.bitsPerPixel
let bpc = cgImage.bitsPerComponent
let cSpace = cgImage.colorSpace
let bmInfo = cgImage.bitmapInfo


var context = CGContext(data: nil, width: width, height: height, bitsPerComponent: bpc, bytesPerRow: 0, space: cSpace!, bitmapInfo: bmInfo.rawValue)

context?.draw(cgImage, in: CGRect(x:0,y:0,width:width,height:height))

let ptr = context?.data

let buffPtr = UnsafeMutableRawBufferPointer(start: ptr, count: width*height*4)


let btmpInf=BitmapInfo(width:width, height:height)

var ids=ImageDataSource(data: buffPtr, bitmapInfo:btmpInf)

print(ids)

let cCube:ColorCube = ColorCube(with:ids)
print(cCube)

print("capacity: \(Stego.Capacity(cCube)) bits")


do{
    let ds = try DataSource(with:Data(contentsOf:URL(fileURLWithPath:"/Users/Eugenijus/Desktop/tv.m3u")))
    print("ds.size \(ds.size)")
    let result = Stego.injectStego2(DataSource:ds, ColorCube:cCube)
    print("injected bits \(result)")
}

let stegoCGImage = context?.makeImage()


let destUrl = URL(fileURLWithPath:"/Users/Eugenijus/Documents/MATLAB/kartinki/test/fruits_stego.png")
var stegoDst = CGImageDestinationCreateWithURL(destUrl as CFURL, "public.png" as CFString, 1, nil)

if stegoDst != nil && stegoCGImage != nil{
    
    CGImageDestinationAddImage(stegoDst!, stegoCGImage!,nil)
    print( CGImageDestinationFinalize(stegoDst!) )
}
/*
let ds = DataSource(with:"Hello World!")
print("ds.size \(ds.size)")
let result = Stego.injectStego2(DataSource:ds, ColorCube:cCube)
print(result)
*/
//cCube.getColorNodes().forEach({e in print(e)})

//let ds = DataSource(with:"Hello World!")
/*
let ds = DataSource(with: try Data(contentsOf: URL(fileURLWithPath:"/Users/Eugenijus/Documents/MATLAB/kartinki/Paint_Horse_Club.jpg")))
print(ds)

if let t = ds.getNextBit() {
    print(t,terminator:"")
    print(ds.getNextBit()!,terminator:"")
    print(ds.getNextBit()!,terminator:"")
    print(ds.getNextBit()!,terminator:"")
    print(ds.getNextBit()!,terminator:"")
    print(ds.getNextBit()!,terminator:"")
    print(ds.getNextBit()!,terminator:"")
    print(ds.getNextBit()!)
    print(ds.lastByte)
 
}

*/
