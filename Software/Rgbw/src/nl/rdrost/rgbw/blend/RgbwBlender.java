package nl.rdrost.rgbw.blend;

import nl.rdrost.rgbw.types.Rgbw;

public class RgbwBlender implements Blender<Rgbw> {
	
	public static final RgbwBlender INSTANCE = new RgbwBlender();
	
	private RgbwBlender() {}

	@Override
	public Rgbw blend(Rgbw value1, Rgbw value2, float factor) {
		return Rgbw.blend(value1, value2, factor);
	}
}
