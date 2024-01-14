#include <Arduino.h>
#include <Wire.h>

#include "I2C.h"
#include "Error.h"
#include "Settings.h"
#include "Strip.h"

#include "PowerMonitor.h"

/** bus voltage range values **/
enum {
  INA219_CONFIG_BVOLTAGERANGE_16V = (0x0000), // 0-16V Range
  INA219_CONFIG_BVOLTAGERANGE_32V = (0x2000), // 0-32V Range
};

enum {
  INA219_CONFIG_GAIN_1_40MV = (0x0000),  // Gain 1, 40mV Range
  INA219_CONFIG_GAIN_2_80MV = (0x0800),  // Gain 2, 80mV Range
  INA219_CONFIG_GAIN_4_160MV = (0x1000), // Gain 4, 160mV Range
  INA219_CONFIG_GAIN_8_320MV = (0x1800), // Gain 8, 320mV Range
};

enum {
  INA219_CONFIG_BADCRES_9BIT = (0x0000),  // 9-bit bus res = 0..511
  INA219_CONFIG_BADCRES_10BIT = (0x0080), // 10-bit bus res = 0..1023
  INA219_CONFIG_BADCRES_11BIT = (0x0100), // 11-bit bus res = 0..2047
  INA219_CONFIG_BADCRES_12BIT = (0x0180), // 12-bit bus res = 0..4097
};

enum {
  INA219_CONFIG_SADCRES_9BIT_1S_84US = (0x0000),   // 1 x 9-bit shunt sample
  INA219_CONFIG_SADCRES_10BIT_1S_148US = (0x0008), // 1 x 10-bit shunt sample
  INA219_CONFIG_SADCRES_11BIT_1S_276US = (0x0010), // 1 x 11-bit shunt sample
  INA219_CONFIG_SADCRES_12BIT_1S_532US = (0x0018), // 1 x 12-bit shunt sample
  INA219_CONFIG_SADCRES_12BIT_2S_1060US =
      (0x0048), // 2 x 12-bit shunt samples averaged together
  INA219_CONFIG_SADCRES_12BIT_4S_2130US =
      (0x0050), // 4 x 12-bit shunt samples averaged together
  INA219_CONFIG_SADCRES_12BIT_8S_4260US =
      (0x0058), // 8 x 12-bit shunt samples averaged together
  INA219_CONFIG_SADCRES_12BIT_16S_8510US =
      (0x0060), // 16 x 12-bit shunt samples averaged together
  INA219_CONFIG_SADCRES_12BIT_32S_17MS =
      (0x0068), // 32 x 12-bit shunt samples averaged together
  INA219_CONFIG_SADCRES_12BIT_64S_34MS =
      (0x0070), // 64 x 12-bit shunt samples averaged together
  INA219_CONFIG_SADCRES_12BIT_128S_69MS =
      (0x0078), // 128 x 12-bit shunt samples averaged together
};

/** shunt voltage register **/
#define INA219_REG_SHUNTVOLTAGE (0x01)

/** bus voltage register **/
#define INA219_REG_BUSVOLTAGE (0x02)

/** power register **/
#define INA219_REG_POWER (0x03)

/** current register **/
#define INA219_REG_CURRENT (0x04)

/** calibration register **/
#define INA219_REG_CALIBRATION (0x05)

/** config register address **/
#define INA219_REG_CONFIG (0x00)

enum {
  INA219_CONFIG_MODE_POWERDOWN,
  INA219_CONFIG_MODE_SVOLT_TRIGGERED,
  INA219_CONFIG_MODE_BVOLT_TRIGGERED,
  INA219_CONFIG_MODE_SANDBVOLT_TRIGGERED,
  INA219_CONFIG_MODE_ADCOFF,
  INA219_CONFIG_MODE_SVOLT_CONTINUOUS,
  INA219_CONFIG_MODE_BVOLT_CONTINUOUS,
  INA219_CONFIG_MODE_SANDBVOLT_CONTINUOUS
};


static constexpr int      ina219_i2caddr  = 0x44;
static constexpr uint32_t ina219_calValue = 81920;
//static constexpr uint16_t ina219_config   = INA219_CONFIG_BVOLTAGERANGE_32V |
//                                            INA219_CONFIG_GAIN_8_320MV | 
//                                            INA219_CONFIG_BADCRES_12BIT |
//                                            INA219_CONFIG_SADCRES_12BIT_1S_532US |
//                                            INA219_CONFIG_MODE_SANDBVOLT_CONTINUOUS;
static constexpr uint16_t ina219_config   = INA219_CONFIG_BVOLTAGERANGE_32V |
                                            INA219_CONFIG_GAIN_1_40MV | 
                                            INA219_CONFIG_BADCRES_12BIT |
                                            INA219_CONFIG_SADCRES_12BIT_1S_532US |
                                            INA219_CONFIG_MODE_SANDBVOLT_CONTINUOUS;
static constexpr uint32_t ina219_currentDivider_mA  = 1;
static constexpr float    ina219_powerMultiplier_mW = 2;

static uint16_t ina219_voltage_mv;
static uint16_t ina219_current_mA;

void PowerMonitorBegin() {
  Wire.beginTransmission(ina219_i2caddr);
  Wire.write(INA219_REG_CALIBRATION);
  Wire.write((ina219_calValue >> 8) & 0xFF);
  Wire.write(ina219_calValue & 0xFF);
  Wire.endTransmission();

  Wire.beginTransmission(ina219_i2caddr);
  Wire.write(INA219_REG_CONFIG);
  Wire.write((ina219_config >> 8) & 0xFF);
  Wire.write(ina219_config & 0xFF);
  Wire.endTransmission();
}

void PowerMonitorLoop() {
  static int state = 0;
  static long previous_time_stamp;

  long time_stamp = micros();
  switch(state) {
  case 0: // BusVoltage send register
    Wire.beginTransmission(ina219_i2caddr);
    Wire.write(INA219_REG_BUSVOLTAGE);
    Wire.endTransmission();
    previous_time_stamp = micros();
    state = 1;
    break;
  case 1: // BusVoltage read value
    if ((time_stamp - previous_time_stamp > 586) && I2cLock()) {
      Wire.requestFrom(ina219_i2caddr, 2);
      ina219_voltage_mv = (((Wire.read() << 8) | Wire.read()) >> 1);
      state          = 2;
      I2cUnlock();

      if(ina219_voltage_mv >= SettingsGetOverVoltageMv()) {
        StripPowerInvalid();
        ErrorActivate(ERROR_OVER_VOLTAGE);
      } else {
        StripPowerValid();
        ErrorDeactivate(ERROR_OVER_VOLTAGE);
      }
    }
  case 2: // BusVoltage send register
    Wire.beginTransmission(ina219_i2caddr);
    Wire.write(INA219_REG_CURRENT);
    Wire.endTransmission();
    previous_time_stamp = micros();
    state = 3;
    break;
  case 3: // BusVoltage read value
    if ((time_stamp - previous_time_stamp > 586) && I2cLock()) {
      Wire.requestFrom(ina219_i2caddr, 2);
      int value         = ((Wire.read() << 8) | Wire.read());
      ina219_current_mA = (int16_t)value / ina219_currentDivider_mA;
      state             = 0;
      I2cUnlock();
    }
  }
}

void PowerMonitorRead(uint16_t& voltage_mv, uint16_t& current_mA) {
  voltage_mv = ina219_voltage_mv;
  current_mA = ina219_current_mA;
}
