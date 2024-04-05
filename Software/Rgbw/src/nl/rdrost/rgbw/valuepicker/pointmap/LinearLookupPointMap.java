package nl.rdrost.rgbw.valuepicker.pointmap;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Objects;
import java.util.Set;

public class LinearLookupPointMap<T> implements PointMap<T> {

	final List<Point<T>> points;
	
	LinearLookupPointMap(final Set<Point<T>> points) {
		Objects.nonNull(points);
		
		this.points = new ArrayList<PointMap.Point<T>>(points);
		Collections.sort(this.points);
	}
	
	private Point<T> point1 = null;
	private Point<T> point2 = null;

	@Override
	public void setDriver(float driver) {
		
		driver = PointMap.noramalizeDriver(driver);
		
		int index1, index2;
		final int point_count = points.size();
		for(index2 = 0; index2 < point_count; index2++) {
			if (points.get(index2).driver >= driver) break;
		}
		if (index2 == 0 || index2 >= point_count) {
			index1 = point_count - 1;
			index2 = 0;
		} else {
			index1 = index2 - 1;
		}
		this.point1 = points.get(index1);
		this.point2 = points.get(index2);
	}

	@Override
	public Point<T> getPoint1() {
		assert(this.point1 != null);
		return this.point1;
	}

	@Override
	public Point<T> getPoint2() {
		assert(this.point2 != null);
		return this.point2;
	}
}
