/// Copyright 2014 Will Fitzgerald. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

package bitset

// // From Wikipedia: http://en.wikipedia.org/wiki/Hamming_weight
// const m1 uint64 = 0x5555555555555555  //binary: 0101...
// const m2 uint64 = 0x3333333333333333  //binary: 00110011..
// const m4 uint64 = 0x0f0f0f0f0f0f0f0f  //binary:  4 zeros,  4 ones ...
// const m8 uint64 = 0x00ff00ff00ff00ff  //binary:  8 zeros,  8 ones ...
// const m16 uint64 = 0x0000ffff0000ffff //binary: 16 zeros, 16 ones ...
// const m32 uint64 = 0x00000000ffffffff //binary: 32 zeros, 32 ones
// const hff uint64 = 0xffffffffffffffff //binary: all ones
// const h01 uint64 = 0x0101010101010101 //the sum of 256 to the power of 0,1,2,3...

// // From Wikipedia: count number of set bits.
// // This is algorithm popcount_2 in the article retrieved May 9, 2011

// func hamming_popcount_2(x uint64) uint64 {
// 	x -= (x >> 1) & m1             //put count of each 2 bits into those 2 bits
// 	x = (x & m2) + ((x >> 2) & m2) //put count of each 4 bits into those 4 bits
// 	x = (x + (x >> 4)) & m4        //put count of each 8 bits into those 8 bits
// 	x += x >> 8                    //put count of each 16 bits into their lowest 8 bits
// 	x += x >> 16                   //put count of each 32 bits into their lowest 8 bits
// 	x += x >> 32                   //put count of each 64 bits into their lowest 8 bits
// 	return x & 0x7f
// }

// From Wikipedia: http://en.wikipedia.org/wiki/Hamming_weight
const ms1 uint32 = 0x55555555  //binary: 0101...
const ms2 uint32 = 0x33333333  //binary: 00110011..
const ms4 uint32 = 0x0f0f0f0f  //binary:  4 zeros,  4 ones ...

// From Wikipedia: count number of set bits.
// This is algorithm popcount_2 in the article retrieved May 9, 2011

// Modified for better performance in 32-bit environments

func hamming_popcount_2(x uint64) uint64 {
	x1 := uint32(x & 0xffffffff)
	x2 := uint32(x >> 32)
	x1 -= (x1 >> 1) & ms1               //put count of each 2 bits into those 2 bits
	x1 = (x1 & ms2) + ((x1 >> 2) & ms2) //put count of each 4 bits into those 4 bits
	x1 = (x1 + (x1 >> 4)) & ms4         //put count of each 8 bits into those 8 bits
	x1 += x1 >> 8                       //put count of each 16 bits into their lowest 8 bits
	x1 += x1 >> 16                      //put count of each 32 bits into their lowest 8 bits
	x2 -= (x2 >> 1) & ms1               //put count of each 2 bits into those 2 bits
	x2 = (x2 & ms2) + ((x2 >> 2) & ms2) //put count of each 4 bits into those 4 bits
	x2 = (x2 + (x2 >> 4)) & ms4         //put count of each 8 bits into those 8 bits
	x2 += x2 >> 8                       //put count of each 16 bits into their lowest 8 bits
	x2 += x2 >> 16                      //put count of each 32 bits into their lowest 8 bits
	return uint64((x1 + x2) & 0x7f)
}

