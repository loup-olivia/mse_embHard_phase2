-------------------------------------------------------------------------------
-- HES-SO Master, projet du cours de EmbHard 
--
-- File         : GPIO.vhd
-- Description  : The file contain a implementation of a GPIO component
--                
--
-- Author       : KENZI Antonin, LOUP Olivia (modification)
-- Date         : 16.10.2024
-- Version      : 1.2
--
-- Dependencies : None
--
--| Modifications |------------------------------------------------------------
-- Version   Author Date               Description
-- 1.0       LOO    11.12.24           Creation of the file
-------------------------------------------------------------------------------


--Convert a internally stored RGB image into gray image.
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rgb2gray is
    generic(
        ADDR_WIDTH : integer := 16; --Address bus size of the Image Ram.
        IM_SIZE_D1 : integer := 64; --Size along Dimension 1
        IM_SIZE_D2 : integer := 64  --Size along Dimension 2
    );
    port (
        Clk : in std_logic;
        reset : in std_logic;   --active high asynchronous reset
        data_valid : out  std_logic;    --High when gray_out has valid output.
        gray_out : out unsigned(7 downto 0) --8 bit gray pixel output
    );
end rgb2gray;

architecture Behav of rgb2gray is

    component im_ram is
        generic(
            ADDR_WIDTH : integer := 16; --Address bus size of the Image Ram.
            IM_SIZE_D1 : integer := 64; --Size along Dimension 1
            IM_SIZE_D2 : integer := 64  --Size along Dimension 2
        );
        port (
            Clk : in std_logic;
            addr_in : in unsigned(ADDR_WIDTH-1 downto 0);   --Address bus to the Image Ram.
            rgb_out : out std_logic_vector(23 downto 0) --24 bit RGB pixel output
        );
    end component;

    signal rgb_out : std_logic_vector(23 downto 0);
    signal addr_in : unsigned(ADDR_WIDTH-1 downto 0);

begin

    --Instantiation of Image RAM. Internally stored image.
    image_ram : im_ram generic map(ADDR_WIDTH,  IM_SIZE_D1 ,IM_SIZE_D2)
        port map(Clk, addr_in, rgb_out);

    --Process to convert RGB to Gray image.
    CONVERTER_PROC : process(Clk,reset)
        --temperary variables
        variable temp1,temp2,temp3,temp4 : unsigned(15 downto 0);
    begin
        if(reset = '1') then    --active high asynchronous reset
            addr_in <= (others => '0');
            data_valid <= '0';
        elsif rising_edge(Clk) then
            --output is ready when the last address in the ram has reached.
            if(to_integer(addr_in) = IM_SIZE_D1*IM_SIZE_D2-1) then  
                addr_in <= (others => '0');
                data_valid <= '0';
            else    --otherwise keep incrementing the address value.
                addr_in <= addr_in + 1;
                data_valid <= '1';  --indicates output is ready
            end if;
            --Gray pixel = 0.3*Red pixel + 0.59*Green pixel + 0.11*Blue pixel
            --the 24 bit value is split into R,G and B components and multiplied
            --with their respective weights and then added together.
            temp1 <= ((rgb_out(11 downto 0) and "0x1F")&"000") *"21";      --(0.3 * R)  
            temp2 <= ((rgb_out(4 downto 9) and "0x3F")&"00") *"7";      --(0.59 * G) 
            temp3 <= ((rgb_out(7 downto 8) and "0x1F")&"000") *"72";  --(0.11 * B)
            temp4 <= temp1 + temp2 + temp3;
            --Most significant bit of the LSB portion is added to the MSB portion. 
            --To round off the result.
            gray_out <= temp4(15 downto 8) + ("0000000" & temp4(7));
        end if;
    end process;

end architecture;