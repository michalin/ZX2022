	public @dtbl
	extrn promdsk,pata0,sersd0

	cseg

	@dtbl	dw promdsk,sersd0,pata0,pata0,pata0,pata0  	; A: EEprom disk, B: Serial disk, C,D,E,F: PATA drive
	dw 0,0,0,0,0,0,0,0,0,0	; drives G-P non-existant

	end
