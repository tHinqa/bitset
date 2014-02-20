package bitset

import "testing"

func BenchmarkLz64_2(b *testing.B) {
	for i := 0; i < b.N; i++ {
		Lzcnt64(0x1)
		Lzcnt64(0x1)
		Lzcnt64(0x1)
		Lzcnt64(0x1)
		Lzcnt64(0x1)
		Lzcnt64(0x1)
	}
}
