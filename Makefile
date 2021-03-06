# Makefile for CROSS-CHASE


ifneq ($(COMSPEC),)
DO_WIN:=1
endif
ifneq ($(ComSpec),)
DO_WIN:=1
endif

ifeq ($(DO_WIN),1)
EXEEXT = .exe
endif

SOURCE_PATH := src

CC65_PATH ?= /cygdrive/c/cc65-snapshot-win32/bin/
#CC65_PATH ?= /home/fcaruso/cc65/bin/
Z88DK_PATH ?= /cygdrive/c/z88dk/bin/
Z88DK_INCLUDE ?= /cygdrive/c/z88dk/include
BUILD_PATH ?= build
MYCC65 ?= cl65$(EXEEXT)
MYZ88DK ?= zcc$(EXEEXT)
MYZ88DKASM ?= z80asm$(EXEEXT)
TOOLS_PATH ?= ./tools


# ------------------------------------------------------------------------------------------
#CC65
# 
atari_color:
	$(CC65_PATH)$(MYCC65) -O -t atari  -DREDEFINED_CHARS -DFULL_GAME -DATARI_MODE1 -DSOUNDS --config $(SOURCE_PATH)/../cfg/atari_mode1_redefined_chars.cfg  $(SOURCE_PATH)/atari/disable_setcursor.s $(SOURCE_PATH)/atari/atari_sounds.c $(SOURCE_PATH)/atari/atari_mode1_redefined_chars_graphics.c  $(SOURCE_PATH)/display_macros.c  $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c  -o $(BUILD_PATH)/FULL_atari_color.xex

atari_no_color:
	$(CC65_PATH)$(MYCC65) -O -t atari -DFULL_GAME -DSOUNDS $(SOURCE_PATH)/atari/atari_sounds.c $(SOURCE_PATH)/display_macros.c  $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c  -o $(BUILD_PATH)/FULL_atari_no_color.xex

atari_no_color_16k:
	$(CC65_PATH)$(MYCC65) -O -t atari -DSOUNDS $(SOURCE_PATH)/atari/atari_sounds.c $(SOURCE_PATH)/display_macros.c  $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c  -o $(BUILD_PATH)/LIGHT_atari_no_color_16k.xex

atari5200:
	$(CC65_PATH)$(MYCC65) -O -t atari5200 $(SOURCE_PATH)/display_macros.c $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c  -o $(BUILD_PATH)/LIGHT_atari5200.rom


atmos:
	$(CC65_PATH)$(MYCC65)  -O  -DSOUNDS -DREDEFINED_CHARS -DFULL_GAME -t atmos --config $(SOURCE_PATH)/../cfg/atmos_better_tap.cfg $(SOURCE_PATH)/atmos/atmos_redefined_characters.c $(SOURCE_PATH)/atmos/atmos_input.c  $(SOURCE_PATH)/display_macros.c $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c  -o $(BUILD_PATH)/FULL_atmos.tap

atmos_16k:
	$(CC65_PATH)$(MYCC65) -O  -DSOUNDS -t atmos --config $(SOURCE_PATH)/../cfg/atmos_better_tap.cfg $(SOURCE_PATH)/atmos/atmos_input.c  $(SOURCE_PATH)/display_macros.c $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c  -o $(BUILD_PATH)/LIGHT_atmos_16k.tap


vic20_exp_16k:
	$(CC65_PATH)$(MYCC65) -O -t vic20 -DFULL_GAME -DSOUNDS --config $(SOURCE_PATH)/../cfg/vic20-16k.cfg $(SOURCE_PATH)/vic20/vic20_sounds.c $(SOURCE_PATH)/display_macros.c $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c  -o $(BUILD_PATH)/FULL_vic20_exp_16k.prg

vic20_exp_8k:
	$(CC65_PATH)$(MYCC65) -O -t vic20  -DSOUNDS --config $(SOURCE_PATH)/../cfg/vic20-8k.cfg $(SOURCE_PATH)/vic20/vic20_sounds.c $(SOURCE_PATH)/display_macros.c $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c  -o $(BUILD_PATH)/LIGHT_vic20_exp_8k.prg

vic20_exp_3k:
	$(CC65_PATH)$(MYCC65) -O -Cl -t vic20 -DNO_SLEEP -DNO_TEXT -DNO_INITIAL_SCREEN -DNO_RANDOM_LEVEL  -DTINY_GAME --config $(SOURCE_PATH)/../cfg/vic20-3k.cfg  $(SOURCE_PATH)/display_macros.c $(SOURCE_PATH)/enemy.c  $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c  -o $(BUILD_PATH)/TINY_vic20_exp_3k.prg
	
c64:
	$(CC65_PATH)$(MYCC65) -O -t c64 -DFULL_GAME -DREDEFINED_CHARS -DSOUNDS --config $(SOURCE_PATH)/../cfg/c64_GFXat0xC000.cfg  $(SOURCE_PATH)/graphics/graphics.s $(SOURCE_PATH)/c64/c64_redefined_characters.c $(SOURCE_PATH)/display_macros.c  $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c  -o $(BUILD_PATH)/FULL_c64.prg
	$(TOOLS_PATH)/exomizer sfx basic $(BUILD_PATH)/FULL_c64.prg -o $(BUILD_PATH)/FULL_c64_exomized.prg
	rm $(BUILD_PATH)/FULL_c64.prg

c128_40col:
	$(CC65_PATH)$(MYCC65) -O -t c128 -DFULL_GAME -DSOUNDS $(SOURCE_PATH)/display_macros.c  $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c  -o $(BUILD_PATH)/FULL_c128_40col.prg

c128_80col:
	$(CC65_PATH)$(MYCC65) -O -D C128_80COL_VIDEO_MODE -DFULL_GAME -DSOUNDS -t c128 $(SOURCE_PATH)/c128/c128_80col_graphics.c $(SOURCE_PATH)/display_macros.c  $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c  -o $(BUILD_PATH)/FULL_c128_80col.prg


c16_16k:
	$(CC65_PATH)$(MYCC65) -O -t c16 -DSOUNDS --config $(SOURCE_PATH)/../cfg/c16-16k.cfg $(SOURCE_PATH)/c264/c264_sounds.c $(SOURCE_PATH)/display_macros.c $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c  -o $(BUILD_PATH)/LIGHT_c16_16k.prg

c16_32k:
	$(CC65_PATH)$(MYCC65) -O -t c16 -DREDEFINED_CHARS -DFULL_GAME -DSOUNDS $(SOURCE_PATH)/c264/c264_graphics.c $(SOURCE_PATH)/c264/c264_sounds.c $(SOURCE_PATH)/display_macros.c $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c  -o $(BUILD_PATH)/FULL_c16_32k.prg


pet:
	$(CC65_PATH)$(MYCC65) -O -t pet -DFULL_GAME $(SOURCE_PATH)/display_macros.c  $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c  -o $(BUILD_PATH)/FULL_pet.prg

cbm610:
	$(CC65_PATH)$(MYCC65) -O -t cbm610 -DFULL_GAME $(SOURCE_PATH)/display_macros.c  $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c  -o $(BUILD_PATH)/FULL_cbm610.prg

cbm510:
	$(CC65_PATH)$(MYCC65) -O -t cbm510 -DFULL_GAME -DSOUNDS $(SOURCE_PATH)/display_macros.c  $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c  -o $(BUILD_PATH)/FULL_cbm510.prg

nes:
	$(CC65_PATH)$(MYCC65) -O -t nes -DFULL_GAME $(SOURCE_PATH)/display_macros.c  $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c  -o $(BUILD_PATH)/FULL_nes.nes
	
apple2:	
	$(CC65_PATH)$(MYCC65) -O -t apple2 -DFULL_GAME $(SOURCE_PATH)/sleep_macros.c $(SOURCE_PATH)/display_macros.c  $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c  -o $(BUILD_PATH)/apple2.bin
	cp $(SOURCE_PATH)/../tools/MASTER_BOOT_ASCHASE.DSK $(BUILD_PATH)/FULL_apple2.dsk
	java -jar $(SOURCE_PATH)/../tools/ac.jar -cc65 $(BUILD_PATH)/FULL_apple2.dsk aschase B < $(BUILD_PATH)/apple2.bin
	rm $(BUILD_PATH)/apple2.bin

apple2enh:
	$(CC65_PATH)$(MYCC65) -O -t apple2enh -DFULL_GAME $(SOURCE_PATH)/sleep_macros.c $(SOURCE_PATH)/display_macros.c  $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c  -o $(BUILD_PATH)/apple2enh.bin
	cp $(SOURCE_PATH)/../tools/MASTER_BOOT_ASCHASE.DSK $(BUILD_PATH)/FULL_apple2enh.dsk
	java -jar $(SOURCE_PATH)/../tools/ac.jar -cc65 $(BUILD_PATH)/FULL_apple2enh.dsk aschase B < $(BUILD_PATH)/apple2enh.bin
	rm $(BUILD_PATH)/apple2enh.bin

osic1p:
	$(CC65_PATH)$(MYCC65) --start-addr 0x200 -Wl -D,__HIMEM__=0x8000 -O -t osic1p -DFULL_GAME $(SOURCE_PATH)/display_macros.c  $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c  -o $(BUILD_PATH)/FULL_osic1p.lod
	$(TOOLS_PATH)/srec_cat $(BUILD_PATH)/FULL_osic1p.lod -binary -offset 0x200 -o $(BUILD_PATH)/FULL_osic1p.c1p -Ohio_Scientific -execution-start-address=0x200	
	rm $(BUILD_PATH)/FULL_osic1p.lod

osic1p_light:
	$(CC65_PATH)$(MYCC65) --start-addr 0x200 -Wl -D,__HIMEM__=0x8000 -O -t osic1p  $(SOURCE_PATH)/display_macros.c  $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c  -o $(BUILD_PATH)/LIGHT_osic1p.lod
	$(TOOLS_PATH)/srec_cat $(BUILD_PATH)/LIGHT_osic1p.lod -binary -offset 0x200 -o $(BUILD_PATH)/LIGHT_osic1p.c1p -Ohio_Scientific -execution-start-address=0x200	
	rm $(BUILD_PATH)/LIGHT_osic1p.lod

osic1p_tiny:
	$(CC65_PATH)$(MYCC65) --start-addr 0x200 -Wl -D,__HIMEM__=0x8000 -O -t osic1p -DTINY_GAME $(SOURCE_PATH)/display_macros.c  $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c  -o $(BUILD_PATH)/TINY_osic1p.lod
	$(TOOLS_PATH)/srec_cat $(BUILD_PATH)/TINY_osic1p.lod -binary -offset 0x200 -o $(BUILD_PATH)/TINY_osic1p.c1p -Ohio_Scientific -execution-start-address=0x200	
	rm $(BUILD_PATH)/TINY_osic1p.lod
		
gamate:
	$(CC65_PATH)$(MYCC65) -O -t gamate --config $(SOURCE_PATH)/../cfg/gamate_reduced_stack.cfg -DFULL_GAME $(SOURCE_PATH)/display_macros.c $(SOURCE_PATH)/gamate/gamate_graphics.c  $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c  -o $(BUILD_PATH)/FULL_gamate.bin
	$(TOOLS_PATH)/gamate-fixcart $(BUILD_PATH)/FULL_gamate.bin

creativision_8k:
	$(CC65_PATH)$(MYCC65) -O -t creativision --config $(SOURCE_PATH)/../cfg/creativision-8k.cfg -DTINY_GAME $(SOURCE_PATH)/display_macros.c  $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c  $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c  -o $(BUILD_PATH)/TINY_creativision_8k.bin

	
# ------------------------------------------------------------------------------------------
#Z88DK

aquarius_exp_16k:
	$(Z88DK_PATH)$(MYZ88DK) +aquarius -clib=ansi -vn -DSOUNDS -D__AQUARIUS__ -DFULL_GAME -lndos -o FULL_aquarius_exp_16k -create-app $(SOURCE_PATH)/display_macros.c $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c
	rm $(SOURCE_PATH)/../FULL_aquarius_exp_16k
	mv $(SOURCE_PATH)/../FULL_aquarius_exp_16k.caq $(BUILD_PATH)
	mv $(SOURCE_PATH)/../_FULL_aquarius_exp_16k.caq $(BUILD_PATH)
	
vz200_16k:	
	$(Z88DK_PATH)$(MYZ88DK) +vz -O3 -vn -DSOUNDS -D__VZ__ -clib=ansi -lndos -create-app -o  $(BUILD_PATH)/LIGHT_vz200_16k.vz $(SOURCE_PATH)/display_macros.c $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c
	rm $(BUILD_PATH)/LIGHT_vz200_16k.cas
	
vz200_32k:
	$(Z88DK_PATH)$(MYZ88DK) +vz -O3 -vn -DSOUNDS -D__VZ__ -DFULL_GAME -clib=ansi -lndos -create-app -o  $(BUILD_PATH)/FULL_vz200_32k.vz $(SOURCE_PATH)/display_macros.c $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c
	rm $(BUILD_PATH)/FULL_vz200_32k.cas
	
# TODO: Adapt code to work with -compiler=sdcc
# -SO3 --max-allocs-per-node200000
# TODO: SLEEP routine should NOT be a macro
vg5k:
	$(Z88DK_PATH)$(MYZ88DK) +vg5k -O3 -vn -D__VG5K__ -DSOUNDS -lndos -pragma-include:$(SOURCE_PATH)/../cfg/zpragma_clib.inc -create-app -o $(BUILD_PATH)/LIGHT_vg5k.prg $(SOURCE_PATH)/sleep_macros.c $(SOURCE_PATH)/vg5k/vg5k_graphics.c $(SOURCE_PATH)/display_macros.c $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c
	rm $(BUILD_PATH)/LIGHT_vg5k.prg
	
vg5k_exp_16k:
	$(Z88DK_PATH)$(MYZ88DK) +vg5k -O3 -DSOUNDS -vn -DFULL_GAME -D__VG5K__ -lndos -create-app -o $(BUILD_PATH)/FULL_vg5k_exp_16k.prg $(SOURCE_PATH)/sleep_macros.c  $(SOURCE_PATH)/vg5k/vg5k_graphics.c $(SOURCE_PATH)/display_macros.c $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c
	rm $(BUILD_PATH)/FULL_vg5k_exp_16k.prg
	
ace_exp_16k:
	$(Z88DK_PATH)$(MYZ88DK) +ace -O3 -D__ACE__ -DFULL_GAME -clib=ansi -o full -Cz--audio -create-app  $(SOURCE_PATH)/zx81/zx81_graphics.c $(SOURCE_PATH)/display_macros.c $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c
	cp full.wav $(BUILD_PATH)/FULL_ace_exp_16k.wav
	rm full.wav
	rm full.tap
	rm full

zx80_exp_16k:
	$(Z88DK_PATH)$(MYZ88DK) +zx80 -O3 -vn -D__ZX80__ -lndos -create-app -o  $(BUILD_PATH)/LIGHT_zx80.prg $(SOURCE_PATH)/zx81/zx81_graphics.c $(SOURCE_PATH)/display_macros.c $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c
	rm $(BUILD_PATH)/LIGHT_zx80.prg

zx80_exp_32k:
	$(Z88DK_PATH)$(MYZ88DK) +zx80 -O3 -vn -D__ZX80__ -DFULL_GAME -lndos -create-app -o  $(BUILD_PATH)/FULL_zx80.prg $(SOURCE_PATH)/zx81/zx81_graphics.c $(SOURCE_PATH)/display_macros.c $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c
	rm $(BUILD_PATH)/FULL_zx80.prg
	
zx81_exp_16k:
	$(Z88DK_PATH)$(MYZ88DK) +zx81 -O3 -vn -D__ZX81__ -lndos -create-app -o  $(BUILD_PATH)/LIGHT_zx81.prg $(SOURCE_PATH)/zx81/zx81_graphics.c $(SOURCE_PATH)/display_macros.c $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c
	rm $(BUILD_PATH)/LIGHT_zx81.prg

zx81_exp_32k:
	$(Z88DK_PATH)$(MYZ88DK) +zx81 -vn -D__ZX81__ -DFULL_GAME -lndos -create-app -o  $(BUILD_PATH)/FULL_zx81.prg $(SOURCE_PATH)/zx81/zx81_graphics.c $(SOURCE_PATH)/display_macros.c $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c
	rm $(BUILD_PATH)/FULL_zx81.prg

cpc:
	$(Z88DK_PATH)$(MYZ88DKASM) -v   -x$(SOURCE_PATH)/../tools/cpcrslib/cpcrslib.lib   @$(SOURCE_PATH)/../tools/cpcrslib/cpcrslib.lst
	$(Z88DK_PATH)$(MYZ88DK) +cpc -O3 -DREDEFINED_CHARS -DSOUNDS -DFULL_GAME -vn -clib=ansi -D__CPC__ -DCPCRSLIB    -l$(SOURCE_PATH)/../tools/cpcrslib/cpcrslib -lndos -create-app -o $(BUILD_PATH)/FULL_cpc.prg $(SOURCE_PATH)/psg/psg_sounds.c $(SOURCE_PATH)/cpc/cpc_cpcrslib_graphics.c $(SOURCE_PATH)/display_macros.c $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c
	$(SOURCE_PATH)/../tools/2cdt.exe -n -r cross_chase $(BUILD_PATH)/FULL_cpc.cpc  $(BUILD_PATH)/FULL_cpc.cdt
	rm $(BUILD_PATH)/FULL_cpc.cpc 
	rm $(BUILD_PATH)/FULL_cpc.prg

msx_color_16k:
	$(Z88DK_PATH)$(MYZ88DK) +msx -O3 -zorg=49200 -DSOUNDS -DREDEFINED_CHARS -create-app -vn -DMSX_MODE1 -D__MSX__ -lndos -create-app -o $(BUILD_PATH)/LIGHT_msx_color_16k.prg $(SOURCE_PATH)/msx/msx_graphics.c $(SOURCE_PATH)/psg/psg_sounds.c $(SOURCE_PATH)/display_macros.c $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c
	rm $(BUILD_PATH)/LIGHT_msx_color_16k.prg 	
	
msx_color_32k:
	$(Z88DK_PATH)$(MYZ88DK) +msx -O3 -DSOUNDS -DREDEFINED_CHARS -create-app -vn -DMSX_MODE1 -DFULL_GAME -D__MSX__ -lndos -create-app -o $(BUILD_PATH)/FULL_msx_color_32k.prg $(SOURCE_PATH)/msx/msx_graphics.c $(SOURCE_PATH)/psg/psg_sounds.c $(SOURCE_PATH)/display_macros.c $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c
	rm $(BUILD_PATH)/FULL_msx_color_32k.prg 

msx_color_32k_rom:
	$(Z88DK_PATH)$(MYZ88DK) +msx -O3 -DSOUNDS -DREDEFINED_CHARS -vn -DMSX_MODE1 -DFULL_GAME -D__MSX__ -lndos -subtype=rom -o $(BUILD_PATH)/FULL_msx_color_32k.rom $(SOURCE_PATH)/msx/msx_graphics.c $(SOURCE_PATH)/psg/psg_sounds.c $(SOURCE_PATH)/display_macros.c $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c
	rm $(BUILD_PATH)/FULL_msx_color_32k_BSS.bin
	rm $(BUILD_PATH)/FULL_msx_color_32k_DATA.bin
	
svi_318_mode0:
	$(Z88DK_PATH)$(MYZ88DK) +svi -O3 -zorg=49200 -vn -lndos -D__SVI__ -DMSX_MODE0 -create-app -o  $(BUILD_PATH)/LIGHT_svi_318_mode0 $(SOURCE_PATH)/svi/svi_graphics.c $(SOURCE_PATH)/display_macros.c $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c
	rm $(BUILD_PATH)/LIGHT_SVI_318_mode0
	
# $(SOURCE_PATH)/svi/svi_graphics.c	
svi_328:
	$(Z88DK_PATH)$(MYZ88DK) +svi -O3 -clib=ansi -pragma-define:ansicolumns=32 -vn -lndos -DSOUNDS -DFULL_GAME -D__SVI__ -create-app -o $(BUILD_PATH)/FULL_svi_328  $(SOURCE_PATH)/psg/psg_sounds.c $(SOURCE_PATH)/display_macros.c $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c
	rm $(BUILD_PATH)/FULL_svi_328

lambda_16k:
	$(Z88DK_PATH)$(MYZ88DK) +lambda -vn -D__LAMBDA__ -DFULL_GAME -lndos -create-app -o  $(BUILD_PATH)/FULL_lambda.prg $(SOURCE_PATH)/zx81/zx81_graphics.c $(SOURCE_PATH)/display_macros.c $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c
	rm $(BUILD_PATH)/FULL_lambda.prg		

sharp_mz:
	$(Z88DK_PATH)$(MYZ88DK) +mz -O3 -D__MZ__ -clib=ansi -pragma-define:ansicolumns=32 -vn -DFULL_GAME -DSOUNDS -DCLIB_ANSI -lndos -create-app -o $(BUILD_PATH)/FULL_sharp_mz.prg  $(SOURCE_PATH)/display_macros.c $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c
	rm $(BUILD_PATH)/FULL_sharp_mz.prg
	mv $(BUILD_PATH)/FULL_sharp_mz.mzt $(BUILD_PATH)/FULL_sharp_mz.mzf
	
microbee_16k:
	$(Z88DK_PATH)$(MYZ88DK) +bee -O3 -D__BEE__ -clib=ansi -vn -DSOUNDS -DCLIB_ANSI -lndos -create-app -o $(BUILD_PATH)/LIGHT_microbee.prg  $(SOURCE_PATH)/display_macros.c $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c
	rm $(BUILD_PATH)/LIGHT_microbee.prg
	
microbee:
	$(Z88DK_PATH)$(MYZ88DK) +bee -O3 -D__BEE__ -clib=ansi -vn -DFULL_GAME -DSOUNDS -DCLIB_ANSI -lndos -create-app -o $(BUILD_PATH)/FULL_microbee.prg  $(SOURCE_PATH)/display_macros.c $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c
	rm $(BUILD_PATH)/FULL_microbee.prg

# import as data into ram at 32768 - call 32768
simcoupe:
	$(Z88DK_PATH)$(MYZ88DK) +sam -O3 -D__SAM__ -clib=ansi -pragma-define:ansicolumns=32 -vn -DFULL_GAME -DSOUNDS -DCLIB_ANSI -o $(BUILD_PATH)/FULL_simcoupe.bin -lndos  $(SOURCE_PATH)/display_macros.c $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c
	
mtx:
	$(Z88DK_PATH)$(MYZ88DK) +mtx -startup=2 -O3 -D__MTX__ -clib=ansi -pragma-define:ansicolumns=32 -create-app -o FULL.bin -vn -DFULL_GAME -DSOUNDS -DCLIB_ANSI -lndos   $(SOURCE_PATH)/display_macros.c $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c
	rm FULL.bin
	rm FULL.wav
	mv FULL $(BUILD_PATH)/FULL_mtx.mtx
	
abc80_16k:
	$(Z88DK_PATH)$(MYZ88DK) +abc80 -lm -subtype=hex -zorg=49200 -O3 -D__ABC80__ -clib=ansi -vn -DSOUNDS -DCLIB_ANSI -lndos -create-app -o a  $(SOURCE_PATH)/display_macros.c $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c
	rm a
	mv a.ihx $(BUILD_PATH)/LIGHT_abc.ihx 
	
abc80_32k:
	$(Z88DK_PATH)$(MYZ88DK) +abc80 -lm -subtype=hex -zorg=49200 -O3 -D__ABC80__ -clib=ansi -vn -DFULL_GAME -DSOUNDS -DCLIB_ANSI -lndos -create-app -o a  $(SOURCE_PATH)/display_macros.c $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c
	rm a
	mv a.ihx $(BUILD_PATH)/FULL_abc.ihx 

p2000_16k:
	$(Z88DK_PATH)$(MYZ88DK) +p2000 -O3 -clib=ansi -D__P2000__ -vn -DSOUNDS -DCLIB_ANSI -lndos -create-app -o $(BUILD_PATH)/LIGHT_p2000.prg  $(SOURCE_PATH)/display_macros.c $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c
	rm $(BUILD_PATH)/LIGHT_p2000.prg
	
p2000_32k:
	$(Z88DK_PATH)$(MYZ88DK) +p2000 -O3 -clib=ansi -D__P2000__ -vn -DFULL_GAME -DSOUNDS -DCLIB_ANSI -lndos -create-app -o $(BUILD_PATH)/FULL_p2000.prg  $(SOURCE_PATH)/display_macros.c $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c
	rm $(BUILD_PATH)/FULL_p2000.prg	
	
# KEYBOARD INPUT PROBLEM
# -DFULL_GAME -DSOUNDS
z9001_16k:
	$(Z88DK_PATH)$(MYZ88DK) +z9001 -O3 -clib=ansi -D__Z9001__ -vn  -DCLIB_ANSI -lndos -create-app -o $(BUILD_PATH)/LIGHT_z9001.z80  $(SOURCE_PATH)/display_macros.c $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c	
	rm $(BUILD_PATH)/LIGHT_z9001.z80
	
z9001_32k:
	$(Z88DK_PATH)$(MYZ88DK) +z9001 -O3 -clib=ansi -D__Z9001__ -vn -DFULL_GAME -DCLIB_ANSI -lndos -create-app -o $(BUILD_PATH)/FULL_z9001.z80  $(SOURCE_PATH)/display_macros.c $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c	
	rm $(BUILD_PATH)/FULL_z9001.z80	

mc1000_16k:
	$(Z88DK_PATH)$(MYZ88DK) +mc1000 -O3 -pragma-define:ansicolumns=32 -subtype=gaming -clib=ansi -D__MC1000__ -DSOUNDS -vn -DCLIB_ANSI -lndos -create-app -Cz--audio $(SOURCE_PATH)/psg/psg_sounds.c $(SOURCE_PATH)/display_macros.c $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c
	mv a.wav $(BUILD_PATH)/LIGHT_mc1000_16k.wav
	rm a.bin
	rm a.cas

mc1000_48k:
	$(Z88DK_PATH)$(MYZ88DK) +mc1000 -O3 -subtype=gaming -pragma-define:ansicolumns=32 -DFULL_GAME  -clib=ansi -D__MC1000__ -DSOUNDS -vn -DCLIB_ANSI -lndos -create-app -Cz--audio $(SOURCE_PATH)/psg/psg_sounds.c $(SOURCE_PATH)/display_macros.c $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c
	mv a.wav $(BUILD_PATH)/FULL_mc1000_48k.wav
	rm a.bin
	rm a.cas		
	
gal_22k:
	$(Z88DK_PATH)$(MYZ88DK) +gal -pragma-need=ansiterminal -vn -D__GAL__ -DFULL_GAME -lndos -create-app -o  $(BUILD_PATH)/FULL_galaksija.prg $(SOURCE_PATH)/display_macros.c $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c
	rm $(BUILD_PATH)/FULL_galaksija.prg	
	rm $(BUILD_PATH)/FULL_galaksija.wav
	
	
	
# -pragma-redirect:ansifont=_font_8x8_zx_system -pragma-define:ansifont_is_packed=0
spectrum_48k:
	$(Z88DK_PATH)$(MYZ88DK) +zx -O3 -clib=ansi  -pragma-redirect:ansifont=_udg -pragma-define:ansifont_is_packed=0 -pragma-define:ansicolumns=32 -vn -DFULL_GAME -DREDEFINED_CHARS -DSOUNDS -DCLIB_ANSI  -D__SPECTRUM__ -lndos -create-app -o $(BUILD_PATH)/FULL_spectrum_48k.prg $(SOURCE_PATH)/spectrum/udg.asm $(SOURCE_PATH)/spectrum/spectrum_graphics.c $(SOURCE_PATH)/display_macros.c $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c
	rm $(BUILD_PATH)/FULL_spectrum_48k.prg
	rm $(BUILD_PATH)/FULL_spectrum_48k_BANK_7.bin	



# DEBUG

vg5k_tiny:
	$(Z88DK_PATH)$(MYZ88DK) +vg5k -O3 -vn -DTINY_GAME -D__VG5K__ -lndos -create-app -o $(BUILD_PATH)/TINY_vg5k.prg $(SOURCE_PATH)/vg5k/vg5k_graphics.c $(SOURCE_PATH)/display_macros.c $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c
	rm $(BUILD_PATH)/TINY_vg5k.prg
	

aquarius_exp_4k:
	$(Z88DK_PATH)$(MYZ88DK) +aquarius -clib=ansi -vn -D__AQUARIUS__ -DTINY_GAME -DNO_TEXT -DNO_INITIAL_SCREEN -DNO_RANDOM_LEVEL -lndos -o TINY_aquarius_exp_4k -create-app $(SOURCE_PATH)/display_macros.c $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c
	rm $(SOURCE_PATH)/../TINY_aquarius_exp_4k
	mv $(SOURCE_PATH)/../TINY_aquarius_exp_4k.caq $(BUILD_PATH)
	mv $(SOURCE_PATH)/../_TINY_aquarius_exp_4k.caq $(BUILD_PATH)


# -DNO_TEXT -DNO_INITIAL_SCREEN -DNO_RANDOM_LEVEL 
# -SO3 --max-allocs-per-node200000
spectrum_newlib_tiny:
	$(Z88DK_PATH)$(MYZ88DK) +zx --opt-code-size  -startup=1 -SO3 --max-allocs-per-node200000 -zorg=24060 -pragma-include:$(SOURCE_PATH)/../cfg/zpragma_clib.inc -clib=sdcc_iy -DNO_SLEEP -DNO_RANDOM_LEVEL -DNO_TEXT -DTINY_GAME -vn  -D__SPECTRUM__ -create-app -o $(BUILD_PATH)/TINY_spectrum_newlib.prg $(SOURCE_PATH)/spectrum/spectrum_graphics.c $(SOURCE_PATH)/display_macros.c  $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c
	rm $(BUILD_PATH)/TINY_spectrum_newlib_CODE.bin 
	rm $(BUILD_PATH)/TINY_spectrum_newlib_UNASSIGNED.bin

spectrum_clib_tiny:
	$(Z88DK_PATH)$(MYZ88DK) +zx -O3 -clib=ansi -pragma-define:ansicolumns=32 -vn                           -DCLIB_ANSI -DNO_SLEEP -DNO_INITIAL_SCREEN -DNO_RANDOM_LEVEL -DNO_TEXT -DTINY_GAME -D__SPECTRUM__ -lndos -create-app -o $(BUILD_PATH)/TINY_spectrum_clib.prg  $(SOURCE_PATH)/spectrum/spectrum_graphics.c $(SOURCE_PATH)/display_macros.c $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c
	rm $(BUILD_PATH)/TINY_spectrum_clib.prg
	rm $(BUILD_PATH)/TINY_spectrum_clib_BANK_7.bin	


	
vic20_debug:
	$(CC65_PATH)$(MYCC65) -O -Cl -t vic20 -DUSE_JOYSTICK -DNO_SLEEP -DNO_TEXT -DNO_INITIAL_SCREEN -DNO_RANDOM_LEVEL  -DTINY_GAME --config $(SOURCE_PATH)/../cfg/vic20-8k.cfg  $(SOURCE_PATH)/display_macros.c $(SOURCE_PATH)/enemy.c  $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c  -o $(BUILD_PATH)/TINY_vic20_DEBUG.prg
	
	
# ISSUE with kbhit and getk: the game is turned-based
gal_tiny:
	$(Z88DK_PATH)$(MYZ88DK) +gal -pragma-need=ansiterminal -vn -DTINY_GAME -D__GAL__ -lndos -create-app -o  $(BUILD_PATH)/TINY_galaksija.prg $(SOURCE_PATH)/display_macros.c $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c
	rm $(BUILD_PATH)/TINY_galaksija.prg
	rm $(BUILD_PATH)/TINY_galaksija.wav	

# gal_16k:
	# $(Z88DK_PATH)$(MYZ88DK) +gal -pragma-need=ansiterminal -vn -D__GAL__ -lndos -create-app -o  $(BUILD_PATH)/LIGHT_galaksija.prg $(SOURCE_PATH)/display_macros.c $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c
	# rm $(BUILD_PATH)/LIGHT_galaksija.prg
	# rm $(BUILD_PATH)/LIGHT_galaksija.wav		
	
	

conio:
	$(CC65_PATH)$(MYCC65) -O -t gamate experiments/conio.c -o  $(BUILD_PATH)/conio.bin
	$(TOOLS_PATH)/gamate-fixcart $(BUILD_PATH)/conio.bin

joy-test:
	$(CC65_PATH)$(MYCC65) -O -t gamate experiments/joy-test.c -o  $(BUILD_PATH)/joy-test.bin
	$(TOOLS_PATH)/gamate-fixcart $(BUILD_PATH)/joy-test.bin

# -DNO_TEXT -DNO_INITIAL_SCREEN -DNO_RANDOM_LEVEL
pce_tiny:
	$(CC65_PATH)$(MYCC65) -O -Cl -t pce -DTINY_GAME -DNO_SLEEP -DNO_RANDOM_LEVEL  --config $(SOURCE_PATH)/../cfg/pce_extra.cfg -DTINY_GAME $(SOURCE_PATH)/display_macros.c  $(SOURCE_PATH)/enemy.c  $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c  -o $(BUILD_PATH)/TINY_PCE.pce


		
gamate_tiny:
	$(CC65_PATH)$(MYCC65) -O -t gamate -DTINY_GAME $(SOURCE_PATH)/display_macros.c $(SOURCE_PATH)/gamate/gamate_graphics.c $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c  -o $(BUILD_PATH)/TINY_gamate.bin
	$(TOOLS_PATH)/gamate-fixcart $(BUILD_PATH)/TINY_gamate.bin
	
gamate_light:
	$(CC65_PATH)$(MYCC65) -O -t gamate $(SOURCE_PATH)/display_macros.c $(SOURCE_PATH)/gamate/gamate_graphics.c  $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c  -o $(BUILD_PATH)/LIGHT_gamate.bin
	$(TOOLS_PATH)/gamate-fixcart $(BUILD_PATH)/LIGHT_gamate.bin

	# TODO: Reduce size in order to compile	
	
# No Image displayed	
atari_lynx:
	$(CC65_PATH)$(MYCC65) -O -t lynx -D__ATARI_LYNX__ $(SOURCE_PATH)/display_macros.c $(SOURCE_PATH)/atari_lynx/atari_lynx_graphics.c $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c  -o $(BUILD_PATH)/LIGHT_ATARI_LYNX.lnx

# -subtype=gaming
mc1000_tiny:
	$(Z88DK_PATH)$(MYZ88DK) +mc1000 -DDEBUG -DTINY_GAME -O3 -pragma-define:ansicolumns=32  -clib=ansi -D__MC1000__ -vn -DCLIB_ANSI -lndos -create-app -Cz--audio $(SOURCE_PATH)/display_macros.c $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c
	mv a.wav $(BUILD_PATH)/TINY_mc1000.wav
	rm a.bin
	rm a.cas	
	
creativision_light:
	$(CC65_PATH)$(MYCC65) -O -t creativision --config $(SOURCE_PATH)/../cfg/creativision-8k.cfg $(SOURCE_PATH)/display_macros.c  $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c  -o $(BUILD_PATH)/LIGHT_creativision.bin	

# NO Image displayed
creativision_full:
	$(CC65_PATH)$(MYCC65) -O -t creativision --config $(SOURCE_PATH)/../cfg/creativision-16k.cfg -DFULL_GAME $(SOURCE_PATH)/display_macros.c  $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c  -o $(BUILD_PATH)/FULL_creativision.bin	

# It lacks conio and TGI
# --config $(SOURCE_PATH)/../cfg/supervision-16k.cfg
supervision_full:
	$(CC65_PATH)$(MYCC65) -O -t supervision  -DFULL_GAME $(SOURCE_PATH)/display_macros.c  $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c  -o $(BUILD_PATH)/FULL_supervision.bin	
		
		
			
	
# osic1p:
	# $(CC65_PATH)$(MYCC65) -O -t osic1p $(SOURCE_PATH)/display_macros.c  $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c  -o $(BUILD_PATH)/LIGHT_osic1p.lod

	

pce_light:
	$(CC65_PATH)$(MYCC65) -O -t pce $(SOURCE_PATH)/display_macros.c  $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c  -o $(BUILD_PATH)/LIGHT_pce.pce

	
nes_color:
	$(CC65_PATH)ca65 $(SOURCE_PATH)/nes/reset.s
	$(CC65_PATH)cc65 -D__NES__ -DNES_COLOR $(SOURCE_PATH)/display_macros.c
	$(CC65_PATH)ca65 $(SOURCE_PATH)/display_macros.s
	$(CC65_PATH)cc65 $(SOURCE_PATH)/enemy.c 
	$(CC65_PATH)ca65 $(SOURCE_PATH)/enemy.s
	$(CC65_PATH)cc65 $(SOURCE_PATH)/level.c 
	$(CC65_PATH)ca65 $(SOURCE_PATH)/level.s
	$(CC65_PATH)cc65 $(SOURCE_PATH)/character.c 
	$(CC65_PATH)ca65 $(SOURCE_PATH)/character.s	
	$(CC65_PATH)cc65 -D__NES__ $(SOURCE_PATH)/text.c 
	$(CC65_PATH)ca65 $(SOURCE_PATH)/text.s 	
	$(CC65_PATH)cc65 $(SOURCE_PATH)/strategy.c 
	$(CC65_PATH)ca65 $(SOURCE_PATH)/strategy.s	
	$(CC65_PATH)cc65 -D__NES__ $(SOURCE_PATH)/input_macros.c
	$(CC65_PATH)ca65 $(SOURCE_PATH)/input_macros.s	
	$(CC65_PATH)cc65 -D__NES__ -DTINY_GAME $(SOURCE_PATH)/main.c 
	$(CC65_PATH)ca65 $(SOURCE_PATH)/main.s		
	$(CC65_PATH)cc65 $(SOURCE_PATH)/nes/nes_graphics.c
	$(CC65_PATH)ca65 $(SOURCE_PATH)/nes/nes_graphics.s		
	$(CC65_PATH)ld65 -t nes -o $(BUILD_PATH)/TINY_nes_color.nes $(SOURCE_PATH)/nes/reset.o $(SOURCE_PATH)/display_macros.o $(SOURCE_PATH)/nes/nes_graphics.o $(SOURCE_PATH)/enemy.o $(SOURCE_PATH)/level.o $(SOURCE_PATH)/character.o $(SOURCE_PATH)/text.o $(SOURCE_PATH)/strategy.o $(SOURCE_PATH)/input_macros.o nes.lib
	#$(CC65_PATH)$(MYCC65) -O -t nes -DTINY_GAME --config $(SOURCE_PATH)/nes/nes.cfg -DNES_COLOR $(SOURCE_PATH)/display_macros.c $(SOURCE_PATH)/nes/reset.s $(SOURCE_PATH)/nes/nes_graphics.c $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c  -o $(BUILD_PATH)/TINY_nes_color.nes
	# -C $(SOURCE_PATH)/nes/nes.cfg
	
nes_16k:
	$(CC65_PATH)$(MYCC65) -O -t nes $(SOURCE_PATH)/display_macros.c  $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c  -o $(BUILD_PATH)/LIGHT_nes.nes

osca:
	$(Z88DK_PATH)$(MYZ88DK) +osca -O3 -clib=ansi -D__OSCA__ -vn -DFULL_GAME -DSOUNDS -DCLIB_ANSI -lndos -create-app -o $(BUILD_PATH)/FULL_osca.exe  $(SOURCE_PATH)/display_macros.c $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c	
	

# Warning at file 'c:/z88dk/\lib\pc6001_crt0.asm' line 112: integer '66384' out of range
# Warning at file 'stdio/ansi/pc6001/f_ansi_char.asm' line 46: integer '66657' out of range
pc6001_32k:
	$(Z88DK_PATH)$(MYZ88DK) +pc6001 -O3 -Cz--audio -clib=ansi -D__PC6001__ -vn -DFULL_GAME -DSOUNDS -DCLIB_ANSI -lndos -create-app -o $(BUILD_PATH)/FULL_pc6001.prg $(SOURCE_PATH)/psg/psg_sounds.c $(SOURCE_PATH)/display_macros.c $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c
	rm $(BUILD_PATH)/FULL_pc6001.prg

pc6001_16k:
	$(Z88DK_PATH)$(MYZ88DK) +pc6001 -O3 -Cz--audio -clib=ansi -D__PC6001__ -vn -DCLIB_ANSI -lndos -create-app -o $(BUILD_PATH)/LIGHT_pc6001.prg  $(SOURCE_PATH)/display_macros.c $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c
	rm $(BUILD_PATH)/LIGHT_pc6001.prg
	
	
# kbhit KO
# Everything displayed on the same line
nascom_32k:
	$(Z88DK_PATH)$(MYZ88DK) +nascom -O3  -pragma-define:ansicolumns=32 -Cz-audio -D__NASCOM__ -vn -DFULL_GAME -DSOUNDS -DCLIB_ANSI -lndos -create-app -o $(BUILD_PATH)/FULL_nascom.prg  $(SOURCE_PATH)/display_macros.c $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c
	rm $(BUILD_PATH)/FULL_nascom.prg
	
	
nascom_16k:
	$(Z88DK_PATH)$(MYZ88DK) +nascom -O3  -pragma-define:ansicolumns=32 -D__NASCOM__ -Cz-audio -vn -DSOUNDS -DCLIB_ANSI -lndos -create-app -o $(BUILD_PATH)/LIGHT_nascom.prg  $(SOURCE_PATH)/display_macros.c $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c	
	rm $(BUILD_PATH)/LIGHT_nascom.prg
	
#All of these may work
ti86s:
	$(Z88DK_PATH)$(MYZ88DK) +ti86s -O3 -D__TI86S__ -clib=ansi -pragma-define:ansicolumns=32 -vn -DFULL_GAME -DSOUNDS -DCLIB_ANSI  -lndos -create-app -o $(BUILD_PATH)/FULL_ti86_mz.prg  $(SOURCE_PATH)/display_macros.c $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c


ti86:
	$(Z88DK_PATH)$(MYZ88DK) +ti86 -O3 -D__TI86__ -clib=ansi -pragma-define:ansicolumns=32 -vn -DFULL_GAME -DSOUNDS -DCLIB_ANSI  -lndos -create-app -o $(BUILD_PATH)/FULL_ti86_mz.prg  $(SOURCE_PATH)/display_macros.c $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c

ti85:
	$(Z88DK_PATH)$(MYZ88DK) +ti85 -O3 -D__TI85__ -clib=ansi -pragma-define:ansicolumns=32 -vn -DFULL_GAME -DSOUNDS -DCLIB_ANSI  -lndos -create-app -o $(BUILD_PATH)/FULL_ti85_mz.prg  $(SOURCE_PATH)/display_macros.c $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c

ti84:
	$(Z88DK_PATH)$(MYZ88DK) +ti84 -O3 -D__TI84__ -clib=ansi -pragma-define:ansicolumns=32 -vn -DFULL_GAME -DSOUNDS -DCLIB_ANSI  -lndos -create-app -o $(BUILD_PATH)/FULL_ti84_mz.prg  $(SOURCE_PATH)/display_macros.c $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c

ti83:
	$(Z88DK_PATH)$(MYZ88DK) +ti83 -O3 -D__TI83__ -clib=ansi -pragma-define:ansicolumns=32 -vn -DFULL_GAME -DSOUNDS -DCLIB_ANSI  -lndos -create-app -o $(BUILD_PATH)/FULL_ti83_mz.prg  $(SOURCE_PATH)/display_macros.c $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c

ti82:
	$(Z88DK_PATH)$(MYZ88DK) +ti82 -O3 -D__TI82__ -clib=ansi -pragma-define:ansicolumns=32 -vn -DFULL_GAME -DSOUNDS -DCLIB_ANSI  -lndos -create-app -o $(BUILD_PATH)/FULL_ti82_mz.prg  $(SOURCE_PATH)/display_macros.c $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c

ti8x:
	$(Z88DK_PATH)$(MYZ88DK) +ti8x -O3 -D__TI8X__ -clib=ansi -pragma-define:ansicolumns=32 -vn -DFULL_GAME -DSOUNDS -DCLIB_ANSI  -lndos -create-app -o $(BUILD_PATH)/FULL_ti8x_mz.prg  $(SOURCE_PATH)/display_macros.c $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c
	
	
# missing conio
srr:
	$(Z88DK_PATH)$(MYZ88DK) +srr -O3  -D__SRR__ -vn -DFULL_GAME -DSOUNDS -DCLIB_ANSI -lndos -create-app -o $(BUILD_PATH)/FULL_srr.prg  $(SOURCE_PATH)/display_macros.c $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c


# it may work
mtx_16k:
	$(Z88DK_PATH)$(MYZ88DK) +mtx -startup=2 -O3 -D__MTX__ -clib=ansi -pragma-define:ansicolumns=32 -vn  -DCLIB_ANSI -lndos -create-app -o LIGHT.bin $(SOURCE_PATH)/display_macros.c $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c
	mv LIGHT $(BUILD_PATH)
	mv LIGHT.bin $(BUILD_PATH)
	mv LIGHT.wav $(BUILD_PATH)
	

# too big for a 16k machine
svi_318:
	$(Z88DK_PATH)$(MYZ88DK) +svi -SO3 -zorg=49200 -clib=ansi -pragma-define:ansicolumns=32 -vn -lndos -DSOUNDS -D__SVI__ -create-app -o $(BUILD_PATH)/LIGHT_svi_318  $(SOURCE_PATH)/psg/psg_sounds.c $(SOURCE_PATH)/display_macros.c $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c
	rm $(BUILD_PATH)/LIGHT_svi_318
	

lambda_light:
	$(Z88DK_PATH)$(MYZ88DK) +lambda -vn -D__LAMBDA__ -lndos -create-app -o  $(BUILD_PATH)/LIGHT_lambda.prg $(SOURCE_PATH)/zx81/zx81_graphics.c $(SOURCE_PATH)/display_macros.c $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c
	rm $(BUILD_PATH)/LIGHT_lambda.prg	
	
msx_no_color_16k:
	$(Z88DK_PATH)$(MYZ88DK) +msx -O3  -zorg=49200 -DSOUNDS -create-app -vn -D__MSX__ -lndos -create-app -o $(BUILD_PATH)/LIGHT_msx_no_color_16k.prg $(SOURCE_PATH)/msx/msx_graphics.c $(SOURCE_PATH)/psg/psg_sounds.c $(SOURCE_PATH)/display_macros.c $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c
	rm $(BUILD_PATH)/LIGHT_msx_no_color_16k.prg 	
		
cpc_color_light:
	$(Z88DK_PATH)$(MYZ88DKASM) -v   -x$(SOURCE_PATH)/../tools/cpcrslib/cpcrslib.lib   @$(SOURCE_PATH)/../tools/cpcrslib/cpcrslib.lst
	$(Z88DK_PATH)$(MYZ88DK) +cpc -O3 -vn -clib=ansi -DREDEFINED_CHARS -D__CPC__ -DCPCRSLIB          -l$(SOURCE_PATH)/../tools/cpcrslib/cpcrslib -lndos -create-app -o $(BUILD_PATH)/LIGHT_cpc_color.prg                                 $(SOURCE_PATH)/cpc/cpc_cpcrslib_graphics.c $(SOURCE_PATH)/display_macros.c $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c
	$(SOURCE_PATH)/../tools/2cdt.exe -n -r cross_chase $(BUILD_PATH)/LIGHT_cpc_color.cpc  $(BUILD_PATH)/LIGHT_cpc_color.cdt
	rm $(BUILD_PATH)/LIGHT_cpc_color.cpc 
	rm $(BUILD_PATH)/LIGHT_cpc_color.prg

cpc_color_sound_light:
	$(Z88DK_PATH)$(MYZ88DKASM) -v   -x$(SOURCE_PATH)/../tools/cpcrslib/cpcrslib.lib   @$(SOURCE_PATH)/../tools/cpcrslib/cpcrslib.lst
	$(Z88DK_PATH)$(MYZ88DK)   +cpc -O3 -vn -clib=ansi -DREDEFINED_CHARS -D__CPC__ -DCPCRSLIB -DSOUNDS -l$(SOURCE_PATH)/../tools/cpcrslib/cpcrslib -lndos -create-app -o $(BUILD_PATH)/LIGHT_cpc_color_sound.prg $(SOURCE_PATH)/psg/psg_sounds.c $(SOURCE_PATH)/cpc/cpc_cpcrslib_graphics.c $(SOURCE_PATH)/display_macros.c $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c
	$(SOURCE_PATH)/../tools/2cdt.exe -n -r cross_chase $(BUILD_PATH)/LIGHT_cpc_color_sound.cpc  $(BUILD_PATH)/LIGHT_cpc_color_sound.cdt
	rm $(BUILD_PATH)/LIGHT_cpc_color_sound.cpc 
	rm $(BUILD_PATH)/LIGHT_cpc_color_sound.prg	

cpc_color_no_sound:
	$(Z88DK_PATH)$(MYZ88DKASM) -v   -x$(SOURCE_PATH)/../tools/cpcrslib/cpcrslib.lib   @$(SOURCE_PATH)/../tools/cpcrslib/cpcrslib.lst
	$(Z88DK_PATH)$(MYZ88DK) +cpc -O3 -DREDEFINED_CHARS           -DFULL_GAME -vn -clib=ansi -D__CPC__   -DCPCRSLIB  -l$(SOURCE_PATH)/../tools/cpcrslib/cpcrslib -lndos -create-app -o $(BUILD_PATH)/FULL_cpc_color_no_sound.prg                                 $(SOURCE_PATH)/cpc/cpc_cpcrslib_graphics.c $(SOURCE_PATH)/display_macros.c $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c
	$(SOURCE_PATH)/../tools/2cdt.exe -n -r cross_chase $(BUILD_PATH)/FULL_cpc_color_no_sound.cpc  $(BUILD_PATH)/FULL_cpc_color_no_sound.cdt
	rm $(BUILD_PATH)/FULL_cpc_color_no_sound.cpc 
	rm $(BUILD_PATH)/FULL_cpc_color_no_sound.prg	
	
# VERY SLOW DUE TO CONIO
cpc_color_no_udg:
	$(Z88DK_PATH)$(MYZ88DK) +cpc -O3 -DREDEFINED_CHARS -vn -DFULL_GAME -clib=ansi -D__CPC__ -lndos -create-app -o $(BUILD_PATH)/FULL_cpc_color_no_udg.prg $(SOURCE_PATH)/cpc/cpc_graphics.c $(SOURCE_PATH)/display_macros.c $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c
	$(SOURCE_PATH)/../tools/2cdt.exe -n -r cross_chase $(BUILD_PATH)/FULL_cpc_color_no_udg.cpc  $(BUILD_PATH)/FULL_cpc_color_no_udg.cdt
	rm $(BUILD_PATH)/FULL_cpc_color_no_udg.cpc 
	rm $(BUILD_PATH)/FULL_cpc_color_no_udg.prg
	
cpc_no_color_no_udg:
	$(Z88DK_PATH)$(MYZ88DK) +cpc -O3 -DREDEFINED_CHARS -DCPC_NO_COLOR -vn -DFULL_GAME -clib=ansi -D__CPC__ -lndos -create-app -o $(BUILD_PATH)/FULL_cpc_no_color.prg $(SOURCE_PATH)/cpc/cpc_graphics.c $(SOURCE_PATH)/display_macros.c $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c
	$(SOURCE_PATH)/../tools/2cdt.exe -n -r cross_chase $(BUILD_PATH)/FULL_cpc_no_color.cpc  $(BUILD_PATH)/FULL_cpc_no_color.cdt
	rm $(BUILD_PATH)/FULL_cpc_no_color.cpc 
	rm $(BUILD_PATH)/FULL_cpc_no_color.prg	

msx_color_32k_msxdos:
	$(Z88DK_PATH)$(MYZ88DK) +msx -O3 -DSOUNDS -DREDEFINED_CHARS -vn -DMSX_MODE1 -DFULL_GAME -D__MSX__ -lndos -subtype=msxdos -o $(BUILD_PATH)/FULL_msx_color_32k.com $(SOURCE_PATH)/msx/msx_graphics.c $(SOURCE_PATH)/psg/psg_sounds.c $(SOURCE_PATH)/display_macros.c $(SOURCE_PATH)/enemy.c $(SOURCE_PATH)/invincible_enemy.c $(SOURCE_PATH)/level.c $(SOURCE_PATH)/character.c $(SOURCE_PATH)/text.c $(SOURCE_PATH)/missile.c $(SOURCE_PATH)/strategy.c $(SOURCE_PATH)/input_macros.c $(SOURCE_PATH)/main.c	
	
.PHONY: mtx vic20exp_8k vic20exp_16k  atari_color atari_no_color atari_no_color_16k atari5200 atmos atmos_16k c128_40col c128_80col c16_16k c16_32k c64 pet cbm510 cbm610 nes apple2 apple2enh

cc65_targets: gamate creativision_8k osic1p osic1p_light osic1p vic20_exp_3k vic20_exp_8k vic20_exp_16k atari_color atari_no_color atari_no_color_16k atari5200 atmos atmos_16k c128_40col c128_80col c16_16k c16_32k c64 pet cbm510 cbm610 nes apple2 apple2enh

z88dk_targets: aquarius_exp_16k ace_exp_16k zx80_exp_16k zx80_exp_32k zx81_exp_16k zx81_exp_32k cpc vz200_16k vz200_32k vg5k vg5k_exp_16k svi_318_mode0 svi_328 msx_color_16k msx_color_32k_rom msx_color_32k lambda_16k sharp_mz microbee simcoupe mtx abc80_16k abc80_32k p2000_16k p2000_32k z9001_16k z9001_32k spectrum_48k

all: cc65_targets z88dk_targets

clean:
	rm -rf $(BUILD_PATH)/*
	rm -rf $(SOURCE_PATH)/*.o
	rm -rf $(SOURCE_PATH)/apple2/*.o
	rm -rf $(SOURCE_PATH)/aquarius/*.o
	rm -rf $(SOURCE_PATH)/atari/*.o
	rm -rf $(SOURCE_PATH)/atmos/*.o
	rm -rf $(SOURCE_PATH)/c64/*.o
	rm -rf $(SOURCE_PATH)/c264/*.o
	rm -rf $(SOURCE_PATH)/c128/*.o
	rm -rf $(SOURCE_PATH)/vic20/*.o
	rm -rf $(SOURCE_PATH)/msx/*.o
	rm -rf $(SOURCE_PATH)/cpc/*.o
	rm -rf $(SOURCE_PATH)/svi/*.o
	rm -rf $(SOURCE_PATH)/vg5k/*.o
	rm -rf $(SOURCE_PATH)/spectrum/*.o
	rm -rf $(SOURCE_PATH)/graphics/*.o
	rm -rf $(SOURCE_PATH)/patch/*.o


help:
	cat BUILD.txt
	cat TARGETS.txt

list:
	cat TARGETS.txt
	
