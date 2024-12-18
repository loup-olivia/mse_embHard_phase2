
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
library work;

entity rgb2gray is
    generic(
        PACKET_SIZE : integer := 32 --Address bus size of the Image Ram.
    );
    port (
        pixel_rgb_in    : in std_logic_vector(15 downto 0);
        pixel_gray_out    : out std_logic_vector(7 downto 0) --8 bit gray pixel output
    );
end rgb2gray;

architecture Behav of rgb2gray is
    
    -- Déclaration of the signals,components,types and procedures
    -- Components (Nomenclature : name of the component + _c)
    -- Types (Nomenclature : name of the type + _t)
    -- exemple : type state_t is (idle, start, stop);
	
    -- Signals (Nomenclature : name of the signal + _s)
    -- exemple : signal a : signed(N_bit-1 downto 0);
    -- Procedures (Nomenclature : name of the procedure + _p)

    signal red,green,blue,temp4: std_logic_vector(PACKET_SIZE-1 downto 0);

    -- Signal interne pour le pixel en niveau de gris
    -- signal rgb_out : std_logic_vector(15 downto 0);
    -- signal pixel_gray_out : std_logic_vector(7 downto 0);
begin
    -- set to 0 unused bits
    red(31 downto 5) <= (others => '0');
    green(31 downto 6) <= (others => '0');
    blue(31 downto 5) <= (others => '0');    
    --Gray pixel = 0.3*Red pixel + 0.59*Green pixel + 0.11*Blue pixel
    --the 24 bit value is split into R,G and B components and multiplied
    --with their respective weights and then added together. 
    red(4 downto 0) <= pixel_rgb_in(15 downto 11); --(0.3 * R)
    green(5 downto 0) <= (pixel_rgb_in(10 downto 5));      --(0.59 * G)
    blue(4 downto 0) <= (pixel_rgb_in(4 downto 0));  --(0.11 * B)
    temp4 <= std_logic_vector(to_unsigned((to_integer(unsigned(red) * 168) + to_integer(unsigned(green) * 288) + to_integer(unsigned(blue) * 56)), 32));
    --Most significant bit of the LSB portion is added to the MSB portion. 
    --To round off the result.
    pixel_gray_out <= (temp4(14 downto 7)) ;--+ ("0000000" & temp4(7));
end architecture;