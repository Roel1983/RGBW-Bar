package nl.rdrost.rgbw.blend;

public interface BlenderFactory {

	public <T> Blender<T> create(final int order, final Class<T> type);

}
