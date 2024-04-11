package nl.rdrost.rgbw.valuepicker.gradient;

public interface Gradient<T> {
	
	public T get(final float driver);
	
	public Class<T> getClassType();

	 
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public static <T> Class<Gradient<T>> getClazz() {
		return (Class)Gradient.class;
	}
	
}
