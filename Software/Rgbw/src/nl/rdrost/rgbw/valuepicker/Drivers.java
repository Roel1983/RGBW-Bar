package nl.rdrost.rgbw.valuepicker;

import java.util.Objects;

public class Drivers {
	
	public enum DriverType {
		TIME,
		WEATHER,
		CLOUDINESS
	}
	
	private final float[] drivers;
	
	public Drivers() {
		this.drivers = new float[DriverType.values().length];
	}
	
	public final void setDriver(final DriverType type, float driver) {
		Objects.nonNull(type);
		this.drivers[type.ordinal()] = driver; 
	}
	
	public final float getDriver(final DriverType type) {
		Objects.nonNull(type);
		return this.drivers[type.ordinal()];
	}	
}
