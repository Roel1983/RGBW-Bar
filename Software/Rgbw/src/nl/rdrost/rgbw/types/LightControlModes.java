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
		// TODO
		return new LightControlModes(Value.NO_CHANGE, Value.NO_CHANGE, Value.NO_CHANGE);
	}
}