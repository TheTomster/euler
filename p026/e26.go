package main

import (
	"fmt"
	"math/big"
	"runtime"
    "sort"
)

const N_CPUS = 4
const PRECISION = 3000

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
	queue := make(chan *big.Int, 1000)
	finished := make(chan int, N_CPUS)
	results := make(chan int, 1000)
	for c := 1; c <= 1000; c++ {
		queue <- big.NewInt(int64(c))
	}
    close(queue)
	for i := 0; i < N_CPUS; i++ {
		go func() {
			for d := range queue {
				results <- period(d)
			}
            finished <- 1
		}()
	}
	for i := 0; i < N_CPUS; i++ {
		<-finished
	}

	result_list := make([]int, 1000)
	for i := 0; i < 1000; i++ {
		result_list[i] = <-results
	}
    sort.Ints(result_list)
    fmt.Println(result_list[999])
}

