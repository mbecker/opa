package main

import (
	"encoding/json"
	"flag"
	"fmt"
	"io/ioutil"
	"log"
	"math/rand"
	"os"
	"time"

	"github.com/rs/xid"
)

/*
"iot": {
    "1-2-3-4": {
      "owner": [
        "mats"
      ]
    },
*/

type IoTDevice struct {
	Owner []string `json:"owner"`
}

type IoTs map[string]IoTDevice

func main() {

	nIterations := flag.Int("number", 0, "How many iterations")
	fileName := flag.String("file", "./data_backup.json", "File path / name")
	fileOut := flag.String("out", "./../policy/data.json", "File output file path")
	flag.Parse()

	// Open our jsonFile
	jsonFile, err := os.Open(*fileName)
	// if we os.Open returns an error then handle it
	if err != nil {
		fmt.Println(err)
	}
	fmt.Println("Successfully opened data_backup.json")
	// defer the closing of our jsonFile so that we can parse it later on
	defer jsonFile.Close()

	// read our opened jsonFile as a byte array.
	byteValue, _ := ioutil.ReadAll(jsonFile)

	var m map[string]interface{}
	json.Unmarshal(byteValue, &m)

	/*
		Random fakte data
	*/
	rand.Seed(time.Now().Unix()) // initialize global pseudo random generator
	ownernames := []string{
		"mats", "lisa", "bob", "alice", "darius", "emil", "chris",
		"gian", "hannes", "jan", "kay", "leon", "thomas", "manuel", "liam", "robert", "michael", "timo", "antje", "herbert", "wolfgang", "mario",
	}
	log.Printf("Number iterations: %d", *nIterations)
	iots := IoTs{}
	for i := 0; i < 9; i++ {
		iots[fmt.Sprintf("a%d", i)] = IoTDevice{Owner: []string{"mats", "lisa"}}
	}
	for i := 0; i < *nIterations; i++ {
		// randomIndex := rand.Intn(len(in))
		// oname := ownernames[randomIndex]
		var oname string
		if i%1000 == 0 {
			oname = "mats"
		} else {
			len := len(ownernames)
			n := uint32(0)
			if len > 0 {
				n = getRandomUint32() % uint32(len)
			}
			oname = ownernames[n]
		}

		guid := xid.New()
		iots[guid.String()] = IoTDevice{Owner: []string{oname}}
	}

	// Write JSON file
	m["iot"] = iots
	file, _ := json.Marshal(m)
	_ = ioutil.WriteFile(*fileOut, file, 0644)

	// Get file size
	fi, err := os.Stat(*fileOut)
	if err != nil {
		log.Panic(err)
	}
	// get the size
	size := fi.Size()
	log.Printf("File size: %d", size)
}

func getRandomUint32() uint32 {
	x := time.Now().UnixNano()
	return uint32((x >> 32) ^ x)
}
