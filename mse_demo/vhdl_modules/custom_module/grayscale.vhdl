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
        ADDR_WIDTH : integer := 16 --Address bus size of the Image Ram.
        -- IM_SIZE_D1 : integer := 40; --Size along Dimension 1
        -- IM_SIZE_D2 : integer := 30  --Size along Dimension 2
    );
    port (
        Clk : in std_logic;
        reset : in std_logic;   --active high asynchronous reset
        data_valid : out  std_logic;    --High when gray_out has valid output.
        gray_out : out unsigned(7 downto 0); --8 bit gray pixel output

        r_in       : in  STD_LOGIC_VECTOR(7 downto 0); -- Entrée Rouge (8 bits)
        g_in       : in  STD_LOGIC_VECTOR(7 downto 0); -- Entrée Vert (8 bits)
        b_in       : in  STD_LOGIC_VECTOR(7 downto 0); -- Entrée Bleu (8 bits)
        valid_in   : in  STD_LOGIC;            -- Pixel valide
        packet_ready : out STD_LOGIC          -- Paquet prêt
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
    -- Taille du paquet (8x8 pixels)
    constant PACKET_SIZE : integer := 8;

    -- Mémoire pour stocker les pixels du paquet courant
    type pixel_array is array(0 to PACKET_SIZE-1, 0 to PACKET_SIZE-1) of STD_LOGIC_VECTOR(7 downto 0);
    signal pixel_buffer : pixel_array := (others => (others => (others => '0')));

    -- Compteurs pour les lignes et colonnes dans le paquet
    signal row_count : integer range 0 to PACKET_SIZE-1 := 0;
    signal col_count : integer range 0 to PACKET_SIZE-1 := 0;

    -- Signal interne pour le pixel en niveau de gris
    signal gray_pixel : STD_LOGIC_VECTOR(7 downto 0);

    -- Signal pour indiquer que le paquet est complet
    signal packet_full : STD_LOGIC := '0';

    signal rgb_out : std_logic_vector(15 downto 0);
    signal addr_in : unsigned(ADDR_WIDTH-1 downto 0);

--begin


    -- component im_ram is
    --     generic(
    --         ADDR_WIDTH : integer := 16; --Address bus size of the Image Ram.
    --         IM_SIZE_D1 : integer := 40; --Size along Dimension 1
    --         IM_SIZE_D2 : integer := 30  --Size along Dimension 2
    --     );
    --     port (
    --         Clk : in std_logic;
    --         addr_in : in unsigned(ADDR_WIDTH-1 downto 0);   --Address bus to the Image Ram.
    --         rgb_out : out std_logic_vector(15 downto 0) --16 bits RGB pixel output
    --     );
    -- end component;



begin

    --Instantiation of Image RAM. Internally stored image.
    -- image_ram : im_ram generic map(ADDR_WIDTH,  IM_SIZE_D1 ,IM_SIZE_D2)
    --     port map(Clk, addr_in, rgb_out);

    --Process to convert RGB to Gray image.
    CONVERTER_PROC : 
    process(Clk,reset)
        --temperary variables
        variable temp1,temp2,temp3,temp4,red,green,blue : unsigned(15 downto 0);
    begin
        if(reset = '1') then    --active high asynchronous reset
            addr_in <= (others => '0');
            data_valid <= '0';
            row_count <= 0;
            col_count <= 0;
            packet_full <= '0';
        elsif rising_edge(Clk) then
            --output is ready when the last address in the ram has reached.
            -- if(to_integer(addr_in) = IM_SIZE_D1*IM_SIZE_D2-1) then  
            --     addr_in <= (others => '0');
            --     data_valid <= '0';
            -- else    --otherwise keep incrementing the address value.
            --     addr_in <= addr_in + 1;
            --     data_valid <= '1';  --indicates output is ready
            -- end if;
            if valid_in = '1' then
                -- Stocker le pixel RGB en niveau de gris
                
                --Gray pixel = 0.3*Red pixel + 0.59*Green pixel + 0.11*Blue pixel
                --the 24 bit value is split into R,G and B components and multiplied
                --with their respective weights and then added together.
                red := unsigned(rgb_out(15 downto 0)) srl 11;      --(0.3 * R) 
                temp1 := (red(4 downto 0) sll 3)*21; 
                green := unsigned(rgb_out(15 downto 0)) srl 5;      --(0.59 * G) 
                temp2 := (green(10 downto 5) sll 2)*72;
                blue := unsigned(rgb_out(15 downto 0)) srl 0;  --(0.11 * B)
                temp3 := (blue(15 downto 11) sll 3)*7;
                temp4 := temp1 + temp2 + temp3;
                --Most significant bit of the LSB portion is added to the MSB portion. 
                --To round off the result.
                pixel_buffer(row_count, col_count) <= std_logic_vector(temp4(15 downto 8)) ;--+ ("0000000" & temp4(7));
                -- Incrémenter le compteur de colonnes
                if col_count = PACKET_SIZE-1 then
                    col_count <= 0;
                    if row_count = PACKET_SIZE-1 then
                        row_count <= 0;
                        packet_full <= '1';  -- Paquet complet
                    else
                        row_count <= row_count + 1;
                    end if;
                else
                    col_count <= col_count + 1;
                end if;
            end if;
        end if;
    end process;
    rgb_out <= std_logic_vector(pixel_buffer(row_count, col_count));

end architecture;