#include "strobe.hpp"

namespace strobe {

using timestamp::Timestamp;

static Timestamp     strobe_on;
static Timestamp     strobe_off;
static uint8_t       strobe_count=0;
static bool          strobe_toggle;
static Timestamp     strobe_next_change;
static Color         strobe_colors[4]  = {{4094, 4094, 4094, 4094},{4094, 4094, 4094, 4094},{4094, 4094, 4094, 4094},{4094, 4094, 4094, 4094}};
static Factor        strobe_strip_weight[4] = {FACTOR_MAX, FACTOR_MAX, FACTOR_MAX, FACTOR_MAX};

void trigger(Timestamp on, Timestamp off, uint8_t count) {
	strobe_on          = on;
	strobe_off         = off;
	strobe_count       = count;
	strobe_toggle      = false;
	strobe_next_change = timestamp::getMsTimestamp();
}

Factor getStripFactor(int index) {
	if (strobe_count == 0) {
		return 0;
	}
	Timestamp timestamp = timestamp::getMsTimestamp();
	if ((long)(strobe_next_change - timestamp) <= 0) {
		strobe_toggle = !strobe_toggle;
		if (strobe_toggle) {
			strobe_next_change += strobe_on;
		} else {
			strobe_next_change += strobe_off;
			if (strobe_count != COUNT_INFINITE) {
				strobe_count--;
			}
		}
	}
	return strobe_toggle ? strobe_strip_weight[index] : 0;  
}

const Color& getStripColor(int index) {
	return strobe_colors[index];
}

void setStripColor(int index, const Color& color) {
	strobe_colors[index][0] = color[0];
	strobe_colors[index][1] = color[1];
	strobe_colors[index][2] = color[2];
	strobe_colors[index][3] = color[3];
}

void setStripWeights(Factor weights[4]) {
	strobe_strip_weight[0] = weights[0];
	strobe_strip_weight[1] = weights[1];
	strobe_strip_weight[2] = weights[2];
	strobe_strip_weight[3] = weights[3];
}

} // End of: namespace strobe
