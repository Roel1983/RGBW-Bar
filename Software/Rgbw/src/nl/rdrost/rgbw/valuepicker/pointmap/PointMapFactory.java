package nl.rdrost.rgbw.valuepicker.pointmap;

import java.util.Set;

import nl.rdrost.rgbw.valuepicker.pointmap.PointMap.Point;

public interface PointMapFactory {

	public <T> PointMap<T> create(Set<Point<T>> points);

}
