#ifndef COMMUNICATION_RECEIVER_RECEIVER_H_
#define COMMUNICATION_RECEIVER_RECEIVER_H_

namespace communication {
namespace receiver {

#ifdef UNITTEST
void tearDown();
#endif

void setup();
void loop();

void ignore(bool);
bool didIgnoreIncomingData();

}} // namespace ::communitation::receiver

#endif  // COMMUNICATION_RECEIVER_RECEIVER_H_
