package nl.rdrost.rgbw.valuepicker;

import nl.rdrost.rgbw.drivers.Drivers;

public interface ValuePicker<T> {
	
	public T get(final Drivers drivers);
}
