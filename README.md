# RadioHeadSW

This is a modified version of the RadioHead Packet Radio library (Original (C) Mike McCauley) for embedded 
microprocessors. 
It provides a complete object-oriented library for sending and receiving 
packetized messages via a variety of common data radios and other transports 
on a range of embedded microprocessors.

This modification attempts to implement a rudimentary stop-and-wait protocol. It is fully backwards-compatible 
with the original library, but does not work particularly well just yet. I encourage anyone who finds this to 
try their hand at making it work.

The [mikem branch](https://github.com/epsilonrt/RadioHead/tree/mikem) contains 
all versions of Mike McCauley without any modification. This branch contains its 
different original versions since 1.74.

The [master branch](https://github.com/epsilonrt/RadioHead) contains a modified 
version of the latest version of RadioHead provided by Mike McCauley.  
This version can be used, of course, on Arduino, but also and above all Pi 
boards (Raspberry Pi, Nano Pi ...) using the 
[piduino](https://github.com/epsilonrt/piduino) library.

For full documentation, please refer to the master branch. This branch provides documentation only for the new 
functions created for this branch.

## New functions:

### virtual bool sendSW (const uint8_t* data, uint8_t len, uint8_t timeout_delay);

This function is used to send messages using the stop-and-wait protocol. It adds a message ID to the header, 
and automatically attempts to retransmit if no acknowledgement is received withing the number of milliseconds 
specified by timeout_delay. After 10 retransmission attempts, it automatically quits.
Currently non-functional.

### virtual uint8_t recvSW (uint8_t* buf, uint8_t* len, bool send_ack);

This function is used to receive messages using the stop-and-wait protocol. It separates the message ID from 
the message and header, and returns that value. If send_ack is set to TRUE, and the received message does not 
start with the acknowledgement flag, it automatically sends an acknowledgement.
The acknowledgement functionality currently does not work. However, it can receive messages and return message IDs.

### virtual bool send_ack (uint8_t ID);

This function is a trimmed-down sender used only for sending acknowledgements. Takes the ID of the message it 
is meant to acknowledge.
Currently non-functional.

## New files (can be found under examples\ask_sw):

### ask_transciever_sw_v0.6a.pde

An example implementing a basic stop-and-wait protocol using the send and receive functions of the original 
RadioHead library. Fully compatible with the original unmodified library.
Unreliable, but technically works.

### ask_transciever_sw_v5.1.1.pde

An example using the new send and receive functions.
Currently non-functional.

### ask_transciever_sw_v5.1.1rx.pde

An example using the new send and receive functions. The send function has been removed to showcase the 
functionality of the new receiver function by itself.
Currently non-functional.

## Trademarks

RadioHead is a trademark of AirSpayce Pty Ltd. The RadioHead mark was first used 
on April 12 2014 for international trade, and is used only in relation to data 
communications hardware and software and related services.  
It is not to be confused with any other similar marks covering other goods and services.

## Donations

This library is offered under a free GPL license for those who want to use it 
that way. We try hard to keep it up to date, fix bugs and to provide free support.  
If this library has helped you save time or money, please consider donating at http://www.airspayce.com

## Copyright

This branch of the software is Copyright (C) 2024 Steampunk483.

The original version of this software is Copyright (C) 2011-2018 Mike McCauley. Use is subject to license conditions. 
The main licensing options available are GPL V2 or Commercial:

### Open Source Licensing GPL V2

This is the appropriate option if you want to share the source code of your application with everyone you distribute it to, 
and you also want to give them the right to share who uses it. 
If you wish to use this software under Open Source Licensing, you must contribute all your source code to the open 
source community in accordance with the GPL Version 2 when your application is distributed. 
See https://www.gnu.org/licenses/gpl-2.0.html

### Commercial Licensing

This is the appropriate option if you are creating proprietary applications and you are not prepared to distribute and 
share the source code of your application. To purchase a commercial license, contact info@airspayce.com
