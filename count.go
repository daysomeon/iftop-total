package main

import (
	"bufio"
	"fmt"
	"os"
	"sort"
	"strconv"
	"strings"
	"time"
)

func main() {

	m := make(map[float64][]int64)
	r, _ := os.Open(os.Args[1])
	scanner := bufio.NewScanner(r)
	for scanner.Scan() {
		//fmt.Println(scanner.Text())
		s := strings.Split(scanner.Text(), ":")
		key, _ := strconv.ParseFloat(s[0], 64)
		value, _ := strconv.ParseInt(s[1], 10, 64)
		m[key] = append(m[key], value) //7.151: 1610593911
	}
	defer r.Close()
	//fmt.Println(barrelSort(m))
	for _, v := range barrelSort(m) {
		for _, j := range m[v] {
			a := j + 40
			fmt.Println(time.Unix(j, 0).Format("2006-01-02 15:04:05"), "-", time.Unix(a, 0).Format("15:04:05"), v)
		}
	}
}

func barrelSort(mm map[float64][]int64) []float64 {
	var sortArry sort.Float64Slice
	for k := range mm {
		sortArry = append(sortArry, k)
	}

	sort.Sort(sort.Reverse(sortArry))
	return sortArry
}

