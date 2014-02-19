package bitset

func naive_popcount_2(x uint64) (ret uint64) {
	var retx uint32
	for x != 0 {
		// ret += x & 1
		// if x & 1 != 0 { ret++ }
		retx += uint32(x) & 1
		x >>= 1
	}
	// return
	return uint64(retx)
}

// func naive_popcount_2(xi uint64) uint64 {
// 	var ret uint32
// 	x := uint32(xi & 0xFFFFFFFF)
// 	for x != 0 {
// 		ret += x & 1
// 		// if x & 1 != 0 { ret++ }
// 		x >>= 1
// 	}
// 	x = uint32(xi >> 32)
// 	for x != 0 {
// 		ret += x & 1
// 		// if x & 1 != 0 { ret++ }
// 		x >>= 1
// 	}
// 	return uint64(ret)
// }

func asmnaive_popcount_2(xi uint64) uint64 {
	x := uint32(xi & 0xFFFFFFFF)
	ret := popcount32(x)
	x = uint32(xi >> 32 & 0xFFFFFFFF)
	ret += popcount32(x)
	return uint64(ret)
}

func popcount32(x uint32) uint32

func (b *BitSet) CountI() uint {
	if b != nil && b.set != nil {
		cnt := uint64(0)
		for _, x := range b.set {
			x1 := uint32(x & 0xffffffff)
			x2 := uint32(x >> 32)
			
			x1 -= (x1 >> 1) & ms1
			x1 = (x1 & ms2) + ((x1 >> 2) & ms2)
			x1 = (x1 + (x1 >> 4)) & ms4
			x1 += x1 >> 8
			x1 += x1 >> 16
			x2 -= (x2 >> 1) & ms1
			x2 = (x2 & ms2) + ((x2 >> 2) & ms2)
			x2 = (x2 + (x2 >> 4)) & ms4
			x2 += x2 >> 8
			x2 += x2 >> 16
			cnt += uint64(x1+x2) & 0x7f
		}
		return uint(cnt)
	}
	return 0
}
