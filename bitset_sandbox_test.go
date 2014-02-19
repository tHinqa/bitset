// Copyright 2014 Will Fitzgerald. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

package bitset

import (
	"testing"
)

func TestCountI(t *testing.T) {
	tot := uint(64*4 + 11) // just some multi unit64 number
	v := New(tot)
	checkLast := true
	for i := uint(0); i < tot; i++ {
		sz := uint(v.CountI())
		if sz != i {
			t.Errorf("CountI reported as %d, but it should be %d", sz, i)
			checkLast = false
			break
		}
		v.Set(i)
	}
	if checkLast {
		sz := uint(v.CountI())
		if sz != tot {
			t.Errorf("(CountI) After all bits set, size reported as %d, but it should be %d", sz, tot)
		}
	}
}

// test setting every 3rd bit, just in case something odd is happening
func TestCount2I(t *testing.T) {
	tot := uint(64*4 + 11) // just some multi unit64 number
	v := New(tot)
	for i := uint(0); i < tot; i += 3 {
		sz := uint(v.CountI())
		if sz != i/3 {
			t.Errorf("CountI reported as %d, but it should be %d", sz, i)
			break
		}
		v.Set(i)
	}
}

func TestNullCountI(t *testing.T) {
	var v *BitSet = nil
	defer func() {
		if r := recover(); r != nil {
			t.Error("(CountI) Counting null reference should not have caused a panic")
		}
	}()
	cnt := v.CountI()
	if cnt != 0 {
		t.Errorf("Count reported as %d, but it should be 0", cnt)
	}
}

// go test -bench=Count*
func BenchmarkCountI(b *testing.B) {
	b.StopTimer()
	s := New(100000)
	for i := 0; i < 100000; i += 100 {
		s.Set(uint(i))
	}
	b.StartTimer()
	for i := 0; i < b.N; i++ {
		s.CountI()
	}
}
func BenchmarkCountIAll0(b *testing.B) {
	b.StopTimer()
	s := New(100000)
	b.StartTimer()
	for i := 0; i < b.N; i++ {
		s.CountI()
	}
}
func BenchmarkCountIAll1(b *testing.B) {
	b.StopTimer()
	s := New(100000)
	for i := 0; i < 100000; i++ {
		s.Set(uint(i))
	}
	b.StartTimer()
	for i := 0; i < b.N; i++ {
		s.CountI()
	}
}
func BenchmarkCountAll0(b *testing.B) {
	b.StopTimer()
	s := New(100000)
	b.StartTimer()
	for i := 0; i < b.N; i++ {
		s.Count()
	}
}
func BenchmarkCountAll1(b *testing.B) {
	b.StopTimer()
	s := New(100000)
	for i := 0; i < 100000; i++ {
		s.Set(uint(i))
	}
	b.StartTimer()
	for i := 0; i < b.N; i++ {
		s.Count()
	}
}
