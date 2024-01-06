#ifndef ERROR_H_
#define ERROR_H_

typedef enum {
  ERROR_COMMUNICATION,
  ERROR_LED_STRIP_ERROR,
  ERROR_OVER_VOLTAGE,
  ERROR_OVER_CURRENT
} error_t;

void ErrorActivate(error_t error);
void ErrorDeactivate(error_t error);
void ErrorRaise(error_t error);

#endif //ERROR_H_
