// ask_transciever_sw_v5.1.1rx.pde
// -*- mode: C++ -*-
// Simple example of how to use RadioHead to transmit messages
// with a simple ASK transmitter in a very simple way.
// Implements a transciever with a basic stop-and-wait protocol
//  using a TX-C1 module for the transmitter 
//  and a RX-B1 module for the receiver
// This transciever is configured to receive messages

#include <RH_ASK.h>

RH_ASK driver;
// RH_ASK driver(2000, 2, 4, 5); // ESP8266 or ESP32: do not use pin 11

void setup()
{
    Serial.begin(9600);    // Debugging only
    if (!driver.init())
         Serial.println("init failed");
}

void loop()
{
  const char *msg = "Hello, World!";
  char *received_message;
  int retransmit_delay = 2 * 1000;  // length of time before message retransmits
                                    // currently set to 2 seconds
  uint8_t buf[RH_ASK_MAX_MESSAGE_LEN];
  uint8_t buflen = sizeof(buf);

  //driver.sendSW((uint8_t *)msg, strlen(msg), retransmit_delay);

  if (driver.recvSW(buf, &buflen, true)) {  // This could be driver.recv(buf, &buflen) instead,
                                      // but you would have to trim the message ID
                                      // and manually send the acknowledgement
      // Convert the buffer to a string of characters
      received_message = (char*)buf;
      Serial.println("Got: ");
      Serial.println(received_message);
  }
} 