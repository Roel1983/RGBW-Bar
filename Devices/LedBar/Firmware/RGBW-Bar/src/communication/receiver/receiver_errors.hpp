#ifndef COMMUNICATION_RECEIVER_RECEIVERERRORS_H_
#define COMMUNICATION_RECEIVER_RECEIVERERRORS_H_

#include "stdint.h"

namespace communication {
namespace receiver {

typedef enum {
	ERROR_NONE,
	ERROR_SIGNAL,
	ERROR_PREAMBLE,
	ERROR_INVALID_LENGTH_1,
	ERROR_INVALID_LENGTH_2,
	ERROR_BUSY,
	ERROR_CRC,
	ERROR_TIMEOUT,
} Error;
constexpr int error_count = 7;

#ifdef UNITTEST
void ReceiverErrorsTearDown();
#endif

void raiseError(const Error error);

}}
#endif // COMMUNICATION_RECEIVER_RECEIVERERRORS_H_
