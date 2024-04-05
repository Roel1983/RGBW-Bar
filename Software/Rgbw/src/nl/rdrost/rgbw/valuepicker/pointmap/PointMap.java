package nl.rdrost.rgbw.valuepicker.pointmap;

import java.util.Objects;

public interface PointMap<T> {
	
	public void setDriver(final float driver);
	public Point<T> getPoint1();
	public Point<T> getPoint2();

	static class Point <T> implements Comparable<Point<T>> {
		public final float driver;
		public final T     value;
		
		public Point(final float driver, final T value) {
			Objects.nonNull(value);
			this.driver = noramalizeDriver(driver);
			this.value  = value;
		}
		
		public final float getDriver() {
			return this.driver;
		}
		
		public final T getValue() {
			return this.value;
		}

		@Override
		public int compareTo(final Point<T> other) {
			return Float.compare(driver, other.driver);
		}
	}
	
	public static float noramalizeDriver(float driver) {
		if (driver < 0.0f) {
			return 1.0f - (float)(driver - Math.floor(driver));
		} else {
			return (float)(driver - Math.floor(driver));
		}
	}
}
