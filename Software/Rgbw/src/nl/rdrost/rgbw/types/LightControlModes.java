package nl.rdrost.rgbw.types;

import java.util.Objects;

public class LightControlModes {
	
	public static enum Value {
		NO_CHANGE ((byte)0b00),
		OFF       ((byte)0b01),     
		ON        ((byte)0b10),
		TOGGLE    ((byte)0b11);
		
		public final byte value;
		
		private Value(final byte value) {
			this.value = value;
		}
		
		private final static Value fromValue(final byte value) {
			for (final Value v : values()) {
				if (v.value == value) {
					return v;
				}
			}
			throw new IllegalArgumentException();
		}
	}
	
	private final Value main;
	private final Value follow;
	private final Value flut;
	
	public LightControlModes(final Value main, final Value follow, final Value flut) {
		Objects.nonNull(main);
		Objects.nonNull(follow);
		Objects.nonNull(flut);
		
		this.main   = main;
		this.follow = follow;
		this.flut   = flut;
	}
	
	public final Value getMain() {
		return this.main;
	}
	
	public final Value getFollow() {
		return this.follow;
	}
	
	public final Value getFlut() {
		return this.flut;
	}
	
	public byte asByte() {
		return (byte)(this.main.value   << 0
				    | this.follow.value << 2
			        | this.flut.value   << 4);
	}
	
	public static LightControlModes fromByte(final byte b) {
		return new LightControlModes(
				Value.fromValue((byte)((b >> 0) & 0b11)),
				Value.fromValue((byte)((b >> 2) & 0b11)), 
				Value.fromValue((byte)((b >> 4) & 0b11)));
	}
	
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("LightControlModes [main=").append(main).append(", follow=").append(follow).append(", flut=")
				.append(flut).append("]");
		return builder.toString();
	}
}