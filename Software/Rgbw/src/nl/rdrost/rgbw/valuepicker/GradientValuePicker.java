package nl.rdrost.rgbw.valuepicker;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Objects;

import nl.rdrost.rgbw.drivers.Drivers;
import nl.rdrost.rgbw.drivers.Drivers.DriverType;
import nl.rdrost.rgbw.valuepicker.gradient.Gradient;

public class GradientValuePicker<T> implements ValuePicker<T> {
	
	private final List<DriverType> driver_types;
	private final Gradient<?>      gradient;
	
	public static <T> GradientValuePicker<T> createFirstOrder(final List<DriverType> driver_types, final Gradient<T> gradient) {
		return new GradientValuePicker<T>(1, driver_types, gradient);
	}
	
	public static <T> GradientValuePicker<T> createSecondOrder(final List<DriverType> driver_types, final Gradient<Gradient<T>> gradient) {
		return new GradientValuePicker<T>(2, driver_types, gradient);
	}
	
	public static <T> GradientValuePicker<T> createThirdOrder(final List<DriverType> driver_types, final Gradient<Gradient<Gradient<T>>> gradient) {
		return new GradientValuePicker<T>(3, driver_types, gradient);
	}
	
	private GradientValuePicker(final int expected_order, List<DriverType> driver_types, Gradient<?> gradient) {
		Objects.nonNull(driver_types);
		Objects.nonNull(gradient);
		
		if (driver_types.size() != expected_order) {
			throw new IllegalArgumentException();
		}
		if (driver_types.contains(null)) {
			throw new IllegalArgumentException();
		}
		
		this.gradient     = gradient;
		this.driver_types = Collections.unmodifiableList(new ArrayList<>(driver_types));
	}

	public final List<DriverType> getDriverTypes() {
		return this.driver_types;
	}
	
	public final Gradient<?> getGradient() {
		return this.gradient;
	}
	
	public final int order() {
		return this.driver_types.size();
	}
	
	@Override
	public T get(final Drivers drivers) {
		
		Gradient<?> current_gradient = this.gradient;
		
		for(final DriverType driver_type : this.driver_types) {
			Object object = current_gradient.get(drivers.getDriver(driver_type));
			if (object instanceof Gradient<?>) {
				current_gradient = (Gradient<?>)object;
			} else {
				@SuppressWarnings("unchecked")
				T result = (T)object;
				return result;
			}
		}
		throw new Error("Should never happen");
	}
}
