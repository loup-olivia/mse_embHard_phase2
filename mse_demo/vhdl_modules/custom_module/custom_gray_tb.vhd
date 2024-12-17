library IEEE;
use IEEE.STD_LOGIC_1164.all;

use std.env.finish;

library work;


use IEEE.NUMERIC_STD.all;
entity tb_custom_gray is
  --  Port ( );
end tb_custom_gray;

architecture Behavioral of tb_custom_gray is
    constant T               : TIME := 20 ns;
    constant RESET_DELAY     : TIME := 60 ns;

    signal tb_dataa : STD_LOGIC_VECTOR(31 downto 0);
    signal tb_datab : STD_LOGIC_VECTOR(31 downto 0);
    signal tb_result : STD_LOGIC_VECTOR(31 downto 0);

    signal tb_red1 : STD_LOGIC_VECTOR(4 downto 0);
    signal tb_green1 : STD_LOGIC_VECTOR(5 downto 0);
    signal tb_blue1 : STD_LOGIC_VECTOR(4 downto 0);

    signal tb_red2 : STD_LOGIC_VECTOR(4 downto 0);
    signal tb_green2 : STD_LOGIC_VECTOR(5 downto 0);
    signal tb_blue2 : STD_LOGIC_VECTOR(4 downto 0);

    signal tb_red3 : STD_LOGIC_VECTOR(4 downto 0);
    signal tb_green3 : STD_LOGIC_VECTOR(5 downto 0);
    signal tb_blue3 : STD_LOGIC_VECTOR(4 downto 0);

    signal tb_red4 : STD_LOGIC_VECTOR(4 downto 0);
    signal tb_green4 : STD_LOGIC_VECTOR(5 downto 0);
    signal tb_blue4 : STD_LOGIC_VECTOR(4 downto 0);


begin
  custom_g : entity work.manageGray
    port map (
        dataa => tb_dataa,
        datab => tb_datab,
        result => tb_result
    );

  verify_result : process
  begin
    -- tb_red1 <= "11111";
    -- tb_green1 <= "111111";
    -- tb_blue1 <= "11111";
  
    tb_red1 <= "00000";
    tb_green1 <= "000000";
    tb_blue1 <= "00000";

    tb_red2 <= "11111";
    tb_green2 <= "111111";
    tb_blue2 <= "11111";

    -- tb_red2 <= "00000";
    -- tb_green2 <= "000000";
    -- tb_blue2 <= "00000";

    tb_red3 <= "00000";
    tb_green3 <= "000000";
    tb_blue3 <= "00000";

    tb_red4 <= "00000";
    tb_green4 <= "000000";
    tb_blue4 <= "00000";

    wait for 1 ns;

    tb_dataa <= tb_blue2 & tb_green2 & tb_red2 & tb_blue1 & tb_green1 & tb_red1;
    tb_datab <= tb_blue4 & tb_green4 & tb_red4 & tb_blue3 & tb_green3 & tb_red3;    
    -- tb_dataa <= "00111000100001000000000000000000";
    -- tb_datab <= "00000000000000000000000000000000";
    wait for 100 ns;

    wait; -- wait infinite 
  end process;


end Behavioral;
