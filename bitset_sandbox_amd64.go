package bitset

// func naive_popcount_2(x uint64) (ret uint64) {
// 	var ret2 uint32
// 	for x != 0 {
// 		// ret += x & 1
// 		// if x & 1 != 0 { ret++ }
// 		ret2 += uint32(x) & 1
// 		x >>= 1
// 	}
// 	// return
// 	return uint64(ret2)
// }

func naive_popcount_2(xi uint64) uint64 {
	var ret uint32
	x := uint32(xi & 0xFFFFFFFF)
	for x != 0 {
		ret += x & 1
		// if x & 1 != 0 { ret++ }
		x >>= 1
	}
	x = uint32(xi >> 32 & 0xFFFFFFFF)
	for x != 0 {
		ret += x & 1
		// if x & 1 != 0 { ret++ }
		x >>= 1
	}
	return uint64(ret)
}

func asmnaive_popcount_2(x uint64) uint64

func (b *BitSet) CountI() uint {
	if b != nil && b.set != nil {
		cnt := uint64(0)
		for _, x := range b.set {
			x -= (x >> 1) & m1             //put count of each 2 bits into those 2 bits
			x = (x & m2) + ((x >> 2) & m2) //put count of each 4 bits into those 4 bits
			x = (x + (x >> 4)) & m4        //put count of each 8 bits into those 8 bits
			x += x >> 8                    //put count of each 16 bits into their lowest 8 bits
			x += x >> 16                   //put count of each 32 bits into their lowest 8 bits
			x += x >> 32                   //put count of each 64 bits into their lowest 8 bits
			cnt += x & 0x7f
		}
		return uint(cnt)
	}
	return 0
}
