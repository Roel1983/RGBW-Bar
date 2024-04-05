package nl.rdrost.rgbw.valuepicker.pointmap;

import java.util.Set;

import nl.rdrost.rgbw.valuepicker.pointmap.PointMap.Point;

public class DefaultPointMapFactory implements PointMapFactory {

	public static final PointMapFactory INSTANCE = new DefaultPointMapFactory();
	
	private DefaultPointMapFactory() {}

	@Override
	public <T> PointMap<T> create(final Set<Point<T>> points) {
		// IMPROVE: Choose the most efficient algorithm for the giver set of points
		return new LinearLookupPointMap<T>(points);
	}
}
