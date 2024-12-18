-------------------------------------------------------------------------------
-- HES-SO Master, projet du cours de EmbHard 
--
-- File         : GPIO.vhd
-- Description  : The file contain a implementation of a GPIO component
--                
--
-- Author       : KENZI Antonin, LOUP Olivia (modification)
-- Date         : 17.12.24
-- Version      : 1.0
--
-- Dependencies : None
--
--| Modifications |------------------------------------------------------------
-- Version   Author Date               Description
-- 1.0       LOO    17.12.24           Creation of the file
-------------------------------------------------------------------------------


--Convert a internally stored RGB image into gray image.
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

library work;
entity manageGray is
    generic(
        PACKET_SIZE : integer := 32
    );
    port (
        signal dataa: in std_logic_vector(31 downto 0);-- Operand A (always required)
        signal datab: in std_logic_vector(31 downto 0);-- Operand B (optional)
        -- Write result to CPU (otherwise write to internal result)
        signal result: out std_logic_vector(31 downto 0)-- result (always required)
    );
end manageGray;

architecture custominstruction_gray of manageGray is
    -- Déclaration of the signals,components,types and procedures
    -- Components (Nomenclature : name of the component + _c)
    -- Types (Nomenclature : name of the type + _t)
    -- exemple : type state_t is (idle, start, stop);
	
    -- Signals (Nomenclature : name of the signal + _s)
    -- exemple : signal a : signed(N_bit-1 downto 0);
    -- Procedures (Nomenclature : name of the procedure + _p)

    type pixel_array is array (0 to 3) of std_logic_vector(15 downto 0);

    signal s_pixel_in_array : pixel_array;
    
    
    begin
        s_pixel_in_array(0) <= dataa(31 downto 16);
        s_pixel_in_array(1) <= dataa(15 downto 0);
        s_pixel_in_array(2) <= datab(31 downto 16);
        s_pixel_in_array(3) <= datab(15 downto 0);
    
        GEN_PARALLEL :
            for K in 0 to 3 generate -- 4 paralell pixel
                GSC : entity work.rgb2gray
                generic map(PACKET_SIZE  => 32)
                port map(
                    pixel_rgb_in => s_pixel_in_array(K),
                    pixel_gray_out => result(7+K*8 downto K*8)
                );
        end generate GEN_PARALLEL;
end architecture;