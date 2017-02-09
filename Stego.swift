//
//  Stego.swift
//  ColorCube
//
//  Created by Eugenijus Margalikas on 17/12/2016.
//  Copyright © 2016 Eugenijus Margalikas. All rights reserved.
//

import Foundation

class Stego{
    /*
    var ims:ImageDataSource
    var ds:DataSource
    var cc:ColorCube
    */
    class func Capacity(_ e:ColorCube)->Int{
        
        var result = 0
        
        
        var c1 = 0
        var c2 = 0
        var c3 = 0
        var c4 = 0
        var c5 = 0
        var c6 = 0
        var c7 = 0
        var c8 = 0
        var c0 = 0
        
        
        e.getColorNodes().forEach(){ c in
            switch c.count{
            case 1 :
                c1 += 1
            case 2 :
                c2 += 1
            case 3 :
                c3 += 1
            case 4 :
                c4 += 1
            case 5 :
                c5 += 1
            case 6 :
                c6 += 1
            case 7 :
                c7 += 1
            case 8 :
                c8 += 1
            case 0 :
                c0 += 1
            default:
                break
                
            }
        }
        
        print("c1 = \(c1), c2 = \(c2), c3 = \(c3), c4 = \(c4), c5 = \(c5), c6 = \(c6), c7 = \(c7), c8 = \(c8), c0 = \(c0)")
        
        result = c1 * 3
        result += c7 * 3
        
        result += ((c2 + c6) / 5) * 24
        result += ((c2 + c6) % 5) * 4
        
        result += ((c3 + c5) / 5) * 29
        result += ((c3 + c5) % 5) * 5
        
        result += ((((c2 + c6) % 5) + ((c3 + c5) % 5)) * 8) % 10
        
        result += (c4 / 8) * 49
        result += (c4 % 8) * 6
        
        return result
    }
    
    static let dataConvert1Bit:[Int:UInt8] = [ 0:1,1:2,2:4,3:8,4:16,5:32,6:64,7:128]
    
    static let dataConvert2Bits:[Int:UInt8] = [0:3,1:5,2:6,3:9,4:10,5:12,6:17,7:18,8:20,9:24,10:33,11:34,12:36,13:40,14:48,15:65,16:66,17:68,18:72,19:80,20:96,21:129,22:130,23:132,24:136,25:144,26:160,27:192]
    static let dataConvert3Bits:[Int:UInt8] = [0:7,1:11,2:13,3:14,4:19,5:21,6:22,7:25,8:26,9:28,10:35,11:37,12:38,13:41,14:42,15:44,16:49,17:50,18:52,19:56,20:67,21:69,22:70,23:73,24:74,25:76,26:81,27:81,28:84,29:88,30:97,31:98,32:100,33:104,34:112,35:131,36:133,37:134,38:137,39:138,40:140,41:145,42:146,43:148,44:152,45:161,46:162,47:164,48:168,49:176,50:193,51:194,52:196,53:200,54:208,55:224]
    static let dataConvert4Bits:[Int:UInt8] = [0:15,1:23,2:27,3:29,4:30,5:39,6:43,7:45,8:46,9:51,10:53,11:54,12:57,13:58,14:60,15:71,16:75,17:77,18:78,19:83,20:85,21:86,22:89,23:90,24:92,25:99,26:101,27:102,28:105,29:106,30:108,31:113,32:114,33:116,34:120,35:135,36:139,37:141,38:142,39:147,40:149,41:150,42:153,43:154,44:156,45:163,46:165,47:166,48:169,49:170,50:172,51:177,52:178,53:180,54:184,55:195,56:197,57:198,58:201,59:202,60:204,61:209,62:210,63:212,64:216,65:225,66:226,67:228,68:232,69:240]
    
    func injectStego(DataSource ds:DataSource, ColorCube cc:ColorCube)->Int{
        
        
        var count=0
        var noMoreData = false
        var temp2Bits: [ColorCube.ColorNode] = []
        
        for node in cc.getColorNodes() {
            
            switch node.count {
            case (let n) where n == 1 || n == 7 :
                var a:UInt8 = 0
                var b:UInt8 = 0
                var c:UInt8 = 0
                
                if let x = ds.getNextBit() {
                    count += 1
                    a = x
                } else {
                    noMoreData = true
                    a = UInt8(arc4random_uniform(1))
                }
                
                if let x = ds.getNextBit() {
                    count += 1
                    b = x
                } else {
                    noMoreData = true
                    b = UInt8(arc4random_uniform(1))
                }
                
                if let x = ds.getNextBit() {
                    count += 1
                    c = x
                } else {
                    noMoreData = true
                    c = UInt8(arc4random_uniform(1))
                }
                
                node.addStego(n==1 ? DataSource.ThreeBitsToUInt8(a:a,b:b,c:c) : ~(DataSource.ThreeBitsToUInt8(a:a,b:b,c:c)) )
            case (let n) where n == 2 || n == 6 :
                temp2Bits.append(node)
                if temp2Bits.count == 5 {
                    
                }
                
            default:
                break
                
            }
            if noMoreData {break}
            
        }
        
        return count
    }
    
    class func injectStego2(DataSource ds:DataSource, ColorCube cc:ColorCube)->Int{
        
        
        var count=0
        var noMoreData = false
        var temp1Bit:  [ColorCube.ColorNode] = []
        var temp2Bits: [ColorCube.ColorNode] = []
        var temp3Bits: [ColorCube.ColorNode] = []
        var temp4Bits: [ColorCube.ColorNode] = []
        
        /*for node in */ cc.getColorNodes().forEach { node in
            
            switch node.count {
            case 1,7 :
                temp1Bit.append(node)
            case 2,6 :
                temp2Bits.append(node)
            case 3,5 :
                temp3Bits.append(node)
            case   4 :
                temp4Bits.append(node)
            default:
                break
            }
        }
        //---------------------------------------------------------------------
        //temp4Bits.forEach{node in print(node)}
        
        if temp4Bits.count > 0 {
            
            // tempCount - not processed nodes
            var tempCount = temp4Bits.count
            
            // continue if there are 8 or more nodes left, so we can use maximum capacity
            while (tempCount / 8) > 0{
                
                // bits count from data source
                var dataCount = 0
                // value made from data source bits
                var dataToInject:UInt64 = 0
                
                // getting data to fill all 8 nodes
                for i:UInt64 in 0...48{
                    if let x = ds.getNextBit() {
                        dataToInject = dataToInject | ( UInt64(x) << i )
                        dataCount += 1
                    } else {
                        noMoreData = true
                        break
                    }
                    
                }
                
                // no data to hide
                if dataCount == 0 { return count }
                //print("here4Bits \(dataCount), \(noMoreData)")
                // hiding data in nodes
                for i in 0...7 {
                    
                    // compute index to use with dataConvert4Bits dict
                    let stegoIndex = Int((dataToInject / UInt64( pow(70,Double(i)) ) ) % 70)
                    
                    // if something went wrong with dict
                    guard let stego = dataConvert4Bits[stegoIndex] else{
                        precondition(false,"ERROR: bad conversion 4Bits index \(stegoIndex)")
                    }
                    
                    // computing index of node to process
                    let index=temp4Bits.count - tempCount + i
                    
                    //print("here4Bits \(stegoIndex), \(stego), \(index)")
                    
                    // injecting data
                    temp4Bits[index].addStego(stego)
                }
                // updating injected bits count
                count += dataCount
                // if no more data in data source
                if noMoreData { return count }
                // updating not processed nodes count for next iteration
                tempCount -= 8
            }
            
        }
        //temp4Bits.forEach{node in print(node)}
        //-----------------------------------------------------------------------
        //temp3Bits.forEach{node in print(node)}
        
        if temp3Bits.count > 0 {
            
            // tempCount - not processed nodes
            var tempCount = temp3Bits.count
            
            // continue if there are 5 or more nodes left, so we can use maximum capacity
            while (tempCount / 5) > 0{
                
                // bits count from data source
                var dataCount = 0
                // value made from data source bits
                var dataToInject:UInt64 = 0
                
                // getting data to fill all 5 nodes
                for i:UInt64 in 0...28{
                    if let x = ds.getNextBit() {
                        dataToInject = dataToInject | ( UInt64(x) << i )
                        dataCount += 1
                    } else {
                        noMoreData = true
                        break
                    }
                    
                }
                
                // no data to hide
                if dataCount == 0 { return count }
                //print("here3Bits \(dataCount), \(noMoreData)")
                // hiding data in nodes
                for i in 0...4 {
                    
                    // compute index to use with dataConvert4Bits dict
                    let stegoIndex = Int((dataToInject / UInt64( pow(56,Double(i)) ) ) % 56)
                    
                    // if something went wrong with dict
                    guard let stego = dataConvert3Bits[stegoIndex] else{
                        precondition(false,"ERROR: bad conversion 3Bits index \(stegoIndex)")
                    }
                    
                    // computing index of node to process
                    let index=temp3Bits.count - tempCount + i
                    
                    //print("here3Bits \(stegoIndex), \(stego), \(index)")
                    
                    // injecting data
                    temp3Bits[index].addStego(temp3Bits[index].count==3 ? stego : ~stego)
                }
                // updating injected bits count
                count += dataCount
                // if no more data in data source
                if noMoreData { return count }
                // updating not processed nodes count for next iteration
                tempCount -= 5
            }
            
        }
        //temp3Bits.forEach{node in print(node)}
        
        //-----------------------------------------------------------------------
        //2bits nodes
        
        if temp2Bits.count > 0 {
            
            // tempCount - not processed nodes
            var tempCount = temp2Bits.count
            
            // continue if there are 5 or more nodes left, so we can use maximum capacity
            while (tempCount / 5) > 0{
                
                // bits count from data source
                var dataCount = 0
                // value made from data source bits
                var dataToInject:UInt64 = 0
                
                // getting data to fill all 8 nodes
                for i:UInt64 in 0...23{
                    if let x = ds.getNextBit() {
                        dataToInject = dataToInject | ( UInt64(x) << i )
                        dataCount += 1
                    } else {
                        noMoreData = true
                        break
                    }
                    
                }
                
                // no data to hide
                if dataCount == 0 { return count }
                //print("here2Bits \(dataCount), \(noMoreData)")
                // hiding data in nodes
                for i in 0...4 {
                    
                    // compute index to use with dataConvert4Bits dict
                    let stegoIndex = Int((dataToInject / UInt64( pow(28,Double(i)) ) ) % 28)
                    
                    // if something went wrong with dict
                    guard let stego = dataConvert2Bits[stegoIndex] else{
                        precondition(false,"ERROR: bad conversion 2Bits index \(stegoIndex)")
                    }
                    
                    // computing index of node to process
                    let index=temp2Bits.count - tempCount + i
                    
                    //print("here2Bits \(stegoIndex), \(stego), \(index)")
                    
                    // injecting data
                    temp2Bits[index].addStego(temp2Bits[index].count==2 ? stego : ~stego)
                }
                // updating injected bits count
                count += dataCount
                // if no more data in data source
                if noMoreData { return count }
                // updating not processed nodes count for next iteration
                tempCount -= 5
            }
            
        }
        
        //-----------------------------------------------------------------------
        // 1 bit nodes
        
        var tempCount = temp1Bit.count
        
        while((tempCount > 0) && !noMoreData ){
            
            var dataCount = 0
            var dataToInject:UInt8 = 0
            
            for i:UInt8 in 0...2{
                if let x = ds.getNextBit() {
                    dataToInject = dataToInject | ( x << i )
                    dataCount += 1
                } else {
                    noMoreData = true
                    break
                }
                
            }
            
            if dataCount == 0 { return count }
            
            guard let stego = dataConvert1Bit[Int(dataToInject)] else { precondition(false,"ERROR: bad conversion 2Bits index \(dataToInject)") }
            
            let index = temp1Bit.count - tempCount
            
            temp1Bit[index].addStego( temp1Bit[index].count == 1 ? stego : ~stego )
            
            count += dataCount
            tempCount -= 1
        }
        
        return count
    }

    
}
