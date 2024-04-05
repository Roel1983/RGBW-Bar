package nl.rdrost.rgbw.valuepicker.gradient;

public interface Gradient<T> {
	
	public T get(final float driver);
	
	public Class<T> getClassType();
	
}
