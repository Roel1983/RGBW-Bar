package nl.rdrost.rgbw.blend;

public class ShortBlender implements Blender<Short> {
	public static final ShortBlender INSTANCE = new ShortBlender();
	
	private ShortBlender() {}
	
	public short blend(short value1, short value2, float factor) {
		final float inverse_factor = 1.0f - factor;
		return (short)(inverse_factor * value1 + factor * value2);
	}

	@Override
	public Short blend(Short value1, Short value2, float factor) {
		return blend(value1.shortValue(), value2.shortValue(), factor);
	}
}
