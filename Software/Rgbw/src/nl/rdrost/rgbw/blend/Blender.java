package nl.rdrost.rgbw.blend;

public interface Blender<I> {
	public I blend(I value1, I value2, float factor);
}
