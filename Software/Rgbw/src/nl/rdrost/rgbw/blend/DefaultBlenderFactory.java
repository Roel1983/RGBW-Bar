package nl.rdrost.rgbw.blend;

import java.util.HashMap;
import java.util.Map;
import java.util.Objects;
import java.util.concurrent.locks.ReentrantReadWriteLock;

import nl.rdrost.rgbw.types.Rgbw;

public class DefaultBlenderFactory implements BlenderFactory {
	
	public static final DefaultBlenderFactory INSTANCE = new DefaultBlenderFactory(); 
	
	private static final ReentrantReadWriteLock lock = new ReentrantReadWriteLock();
	private static final Map<Class<?>, Blender<?>> blenders = new HashMap<>();
	
	static {
		DefaultBlenderFactory.register(Rgbw.class,  RgbwBlender.INSTANCE);
		DefaultBlenderFactory.register(Short.class, ShortBlender.INSTANCE);
	}
	
	private DefaultBlenderFactory() {}
	
	public static <T> void register(final Class<T> type, final Blender<T> blender) {
		Objects.nonNull(type);
		Objects.nonNull(blender);
		
		lock.writeLock().lock();
		try {
			blenders.put(type, blender);
		} finally {
			lock.writeLock().unlock();
		}
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public <T> Blender<T> create(final Class<T> type) {
		lock.readLock().lock();
		try {
			final Blender<T> blender = (Blender<T>)blenders.get(type);
			if(blender == null) {
				throw new IllegalArgumentException(String.format("No Blender registered for %s", type.getSimpleName()));
			}
			return (Blender<T>)blenders.get(type);
		} finally {
			lock.readLock().unlock();
		}
	}
}
