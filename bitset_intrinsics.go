package bitset

const popcnt uint32 = 1 << 23

func cpuHasPopcnt() bool {
	if cpuidcx() & popcnt != 0 {
		return true
	}
	return false
}

func cpuidcx() (flags uint32)
