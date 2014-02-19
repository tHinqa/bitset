package bitset

func intrinsic_popcount_2(xi uint64) uint64 {
	x1 := uint32(xi & 0xFFFFFFFF)
	x2 := uint32(xi >> 32)
	ret := Popcnt32(x1)
	ret += Popcnt32(x2)
	return uint64(ret)
}

// CPU instructions
func Popcnt32(x uint32) uint32
func Lzcnt32(x uint32) uint32

// Fallback function
func Clz32(x uint32) uint32
func Clz64(x uint64) (ret uint32) {
	ret = Clz32(uint32(x >> 32))
	if ret == 32 {
	    ret += Clz32(uint32(x & 0xFFFFFFFF))
	}
	return
}
