package bitset

func intrinsic_popcount_2(xi uint64) uint64 {
	x1 := uint32(xi & 0xFFFFFFFF)
	x2 := uint32(xi >> 32)
	ret := Popcnt32(x1)
	ret += Popcnt32(x2)
	return uint64(ret)
}

func Popcnt32(x uint32) uint32
func Lzcnt32(x uint32) uint32
