package bitset

func intrinsic_popcount_2(x uint64) uint64 {
	return Popcnt64(x)
}

// func intrinsic_popcount_2(xi uint64) (ret uint64) {
// 	x := uint32(xi & 0xFFFFFFFF)
// 	ret := Popcnt32(x)
// 	x = uint32(xi >> 32 & 0xFFFFFFFF)
// 	ret += Popcnt32(x)
// 	return
// }

// CPU instructions
func Popcnt32(x uint32) uint32
func Popcnt64(x uint64) uint64

// CPU instructions
func Lzcnt32(x uint32) uint32
func Lzcnt64(x uint64) uint32

// Fallbacks
func Clz32(x uint32) uint32
func Clz64(x uint64) uint32
