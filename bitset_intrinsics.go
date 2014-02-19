package bitset

const lzcnt uint32 = 1 << 5
const popcnt uint32 = 1 << 23

func cpuHasPopcnt() bool {
	if cpuidcx() & popcnt != 0 {
		return true
	}
	return false
}

func cpuHasLzcnt() bool {
	if cpuidcx() & lzcnt != 0 {
		return true
	}
	return false
}

func cpuidcx() (flags uint32)
