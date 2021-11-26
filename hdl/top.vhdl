library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library blink_lib;
use blink_lib.blink_pkg.all;

entity Top is
  generic (
    BOO : boolean:=FALSE;
    INT : integer:=0;
    LOG : std_logic:='0';
    VEC : std_logic_vector(7 downto 0):="00000000";
    STR : string:="ABCD";
    REA : real:=0.0
  );
  port (
    clk_i :  in std_logic;
    led_o : out std_logic
  );
end entity Top;

architecture EMPTY of Top is
begin

  led_o <= '1';

end architecture EMPTY;

architecture VIVADO of Top is
begin

  inst: if BOO=TRUE and INT=255 and LOG='1' and VEC="11111111" and STR="WXYZ" and REA=1.1 generate
    blink_i: Blink
    generic map (FREQ => 125e6, SECS => 1)
    port map (clk_i => clk_i, led_o => led_o);
  end generate inst;

end architecture VIVADO;
