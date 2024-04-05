package nl.rdrost.rgbw.valuepicker.gradient;

import java.util.HashSet;
import java.util.Objects;
import java.util.Set;

import nl.rdrost.rgbw.blend.Blender;
import nl.rdrost.rgbw.blend.BlenderFactory;
import nl.rdrost.rgbw.blend.DefaultBlenderFactory;
import nl.rdrost.rgbw.valuepicker.pointmap.DefaultPointMapFactory;
import nl.rdrost.rgbw.valuepicker.pointmap.PointMap;
import nl.rdrost.rgbw.valuepicker.pointmap.PointMapFactory;

public class GradientFactory<T> {
	public static enum Type {
		LINEAR {
			@Override
			<T> LinearGradient<T> create(GradientFactory<T> factory) {
				final PointMap<T> map     = factory.point_map_factory.create(factory.points);
				final Blender<T>  blender = factory.blender_factory.create(factory.class_type);
				LinearGradient<T> result = new LinearGradient<T>(factory.class_type, map, blender);
				return result;
			}
		};

		abstract <T> LinearGradient<T> create(GradientFactory<T> gradientFactory);
	};
	
	public static final Type DEFAULT_TYPE     = Type.LINEAR;
	
	private Class<T>        class_type;
	private Type            type              = DEFAULT_TYPE;
	
	private PointMapFactory point_map_factory = DefaultPointMapFactory.INSTANCE;
	private BlenderFactory  blender_factory   = DefaultBlenderFactory.INSTANCE;
	
	private Set<PointMap.Point<T>> points     = new HashSet<>(); 
	
	public GradientFactory(final Class<T> type) {
		Objects.nonNull(type);
		this.class_type = type;
	}
	
	public GradientFactory<T> setPointMapFactory(final PointMapFactory factory) {
		Objects.nonNull(factory);
		this.point_map_factory = factory;
		return this;
	}
	
	public GradientFactory<T> setBlenderFactory(final BlenderFactory factory) {
		Objects.nonNull(factory);
		this.blender_factory = factory;
		return this;
	}
	
	public GradientFactory<T> setType(final Type type) {
		Objects.nonNull(type);
		this.type = type;
		return this;
	}
	
	public GradientFactory<T> put(final float driver, final T value) {
		return put(new PointMap.Point<>(driver, value));
	}
	
	public GradientFactory<T> put(final PointMap.Point<T> point) {
		Objects.nonNull(point);
		this.points.add(point);
		return this;
	}
	
	public LinearGradient<T> create() {
		return this.type.create(this);
	}
}
