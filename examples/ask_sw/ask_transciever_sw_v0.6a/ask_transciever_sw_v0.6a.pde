// ask_transmitter_v0.6a.pde
// -*- mode: C++ -*-
// Simple example of how to use RadioHead to transmit messages
//  with a simple ASK transmitter in a very simple way.
// Implements a transciever with a basic stop-and-wait protocol.
//  using a TX-C1 module for the transmitter 
//  and a RX-B1 module for the receiver
// This example is fully compatible with the original RadioHead library

#include <RH_ASK.h>
#include <Timer.h>

Timer timer;
RH_ASK driver;
// RH_ASK driver(2000, 2, 4, 5); // ESP8266 or ESP32: do not use pin 11

void setup()
{
    Serial.begin(9600);    // Debugging only
    if (!driver.init())
         Serial.println("init failed");
}

void loop() {
  const char *msg = "Hello, world!";
  const int retransmit_delay = 2000;
  const uint8_t ack = 0xFF;
  const bool waiting_for_ack = false;
  const bool ret = false;
  uint8_t buf[RH_ASK_MAX_MESSAGE_LEN] = {};
  uint8_t buflen = sizeof(buf);

  driver.waitPacketSent();
  if (ret) {
      Serial.println("Retransmitting...");
      ret = false;
    }
  if(driver.send((uint8_t *)msg, strlen(msg))) {
    Serial.println("Sent!");
    waiting_for_ack = true;
    timer.start();
  }
  else {
    Serial.println("Message failed to send!");
  }
  while (waiting_for_ack) {
    if (timer.read() <= retransmit_delay) {
      if (driver.recv(buf, &buflen)) {
        driver.printBuffer("Got:", buf, buflen);
        Serial.println((char*)buf);
        if (strpbrk(buf, ack) == buf) {
          Serial.println("Acknowledgement received!");
          timer.stop();
          waiting_for_ack = false;
        }
        else if (strpbrk(buf, ack) != buf) {
          driver.waitPacketSent();
          if (driver.send(ack, 2)) 
          {Serial.println("Acknowledgement sent!");}
        }
      }
    }
    else {
      timer.stop();
      waiting_for_ack = false;
      Serial.println("Message timed out!");
      ret = true;
    }
  }
}
