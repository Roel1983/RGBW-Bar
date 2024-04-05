package nl.rdrost.rgbw.blend;

public interface BlenderFactory {

	public <T> Blender<T> create(final Class<T> type);

}
