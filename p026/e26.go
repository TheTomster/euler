package main

import (
	"fmt"
	"math/big"
	"runtime"
	"sort"
)

const N_CPUS = 4
const PRECISION = 3000
const TARGET = 1000

func period(d *big.Int) int {
	f := new(big.Int)
	n := new(big.Int)
	n.Exp(big.NewInt(10), big.NewInt(PRECISION), nil)
	f.Div(n, d)
	s := f.String()
	last_index := len(s) - 1
	half_index := len(s) / 2
	for i := 1; i < half_index; i++ {
		pivot := last_index - i
		front := last_index - (2 * i)
		s1 := s[front:pivot]
		s2 := s[pivot:last_index]
		if s1 == s2 {
			if s1 == "0" {
				return 0
			}
			return len(s1)
		}
	}
	return 0
}

func main() {
	runtime.GOMAXPROCS(N_CPUS)
	fmt.Println("Project Euler 26")
	queue := make(chan *big.Int, 512)
	finished := make(chan int, N_CPUS+1)
	results := make(chan int, 512)
	result_list := make([]int, TARGET)

	// set up result grabber
	go func() {
		for i := 0; i < TARGET; i++ {
			result_list[i] = <-results
		}
		finished <- 1
	}()

	// set up one worker per cpu
	for i := 0; i < N_CPUS; i++ {
		go func() {
			for d := range queue {
				results <- period(d)
			}
			finished <- 1
		}()
	}

	// fill the work queue and wait for the workers to signal completion
	for c := 1; c <= TARGET; c++ {
		queue <- big.NewInt(int64(c))
	}
	close(queue)
	for i := 0; i < (N_CPUS + 1); i++ {
		<-finished
	}

	sort.Ints(result_list)
	fmt.Println(result_list[TARGET-1])
}
