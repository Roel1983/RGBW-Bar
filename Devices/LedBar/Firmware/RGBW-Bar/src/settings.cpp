#include "settings.hpp"

namespace settings {
	
const Color& getWorkLightColor() {
	static constexpr Color WORK_LIGHT_COLOR = {1500, 1500, 1500, 3000};
	return WORK_LIGHT_COLOR;
}

const Color& getFlutLightColor() {
	static constexpr Color FLUT_LIGHT_COLOR = {4094, 4094, 4094, 4094};
	return FLUT_LIGHT_COLOR;
}

} // End of: namespace settings
