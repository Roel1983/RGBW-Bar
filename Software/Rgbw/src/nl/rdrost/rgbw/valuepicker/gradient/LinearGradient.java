package nl.rdrost.rgbw.valuepicker.gradient;

import nl.rdrost.rgbw.blend.Blender;
import nl.rdrost.rgbw.valuepicker.pointmap.PointMap;

public class LinearGradient<T> implements Gradient<T> {
	private final Class<T>    class_type;
	private final PointMap<T> map;
	private final Blender<T>  blender;
	
	LinearGradient(final Class<T> class_type, final PointMap<T> map, final Blender<T> blender) {
		this.class_type = class_type;
		this.map     = map;
		this.blender = blender;
	}
	
	@Override
	public final Class<T> getClassType() {
		return this.class_type;
	}
	
	@Override
	public T get(final float driver) {
		final PointMap.Point<T> point1, point2;
		synchronized (this.map) {
			this.map.setDriver(driver);
			point1 = this.map.getPoint1();
			point2 = this.map.getPoint2();			
		}
		
		float driver1 = point1.driver;
		float driver2 = point2.driver;
		if (driver2 < driver1) driver2 += 1.0;
		float factor = (driver - driver1) / (driver2 - driver1);
		
		return this.blender.blend(point1.value, point2.value, factor);
	}
}
