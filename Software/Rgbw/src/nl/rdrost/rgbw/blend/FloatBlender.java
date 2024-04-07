package nl.rdrost.rgbw.blend;

public class FloatBlender implements Blender<Float> {
	public static final FloatBlender INSTANCE = new FloatBlender();
	
	private FloatBlender() {}
	
	public float blend(float value1, float value2, float factor) {
		final float inverse_factor = 1.0f - factor;
		return (inverse_factor * value1 + factor * value2);
	}

	@Override
	public Float blend(Float value1, Float value2, float factor) {
		return blend(value1.floatValue(), value2.floatValue(), factor);
	}
}
