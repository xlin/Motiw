package main

import (
        "fmt"
        "net"

        "github.com/jjeffery/stomp"
)

func main() {
        netConn, err := net.Dial("tcp", "office.motiw.ru:61616")
        if err != nil {
                fmt.Println("[ERROR 2]")
        }
        stompConn, err := stomp.Connect(netConn, stomp.Options{})
        if err != nil {
                fmt.Println("[ERROR 3]")
        }
        defer stompConn.Disconnect()
}
