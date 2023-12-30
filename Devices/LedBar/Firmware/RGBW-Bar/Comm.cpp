#include <Arduino.h>

static constexpr size_t comm_tx_en_pinnr = 17;
static constexpr long   comm_baudrate    = 115200;

void CommStart() {
  static constexpr long b = (long)comm_baudrate * 1600 / 1475;
  
  Serial.begin(b);
  pinMode(comm_tx_en_pinnr, OUTPUT);
}

void CommSend(char *buffer, size_t size) {
  digitalWrite(comm_tx_en_pinnr, HIGH);
  Serial.print(buffer);
  Serial.flush();
  digitalWrite(17, LOW);  
}

