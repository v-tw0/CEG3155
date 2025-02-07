library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity BaudRateGenerator is
    Port ( 
           i_reset : in std_logic;
           i_clk : in std_logic;
           i_selec : in std_logic_vector(2 downto 0);
           o_Bclk : out std_logic;
           o_Bclkx8 : out std_logic
    );
end BaudRateGenerator;

architecture Structural of BaudRateGenerator is

    signal count256 : std_logic_vector(7 downto 0);
    signal Bclockx8 : std_logic;
    signal Bclock : std_logic_vector(2 downto 0);

begin

    divcount256 : entity work.counter8bit(Structural)
        port map (
            '1',
            i_clk,
            i_reset,
            count256
        );

    selmux : entity work.mux8x11bit(Structural)
        port map (
            count256,
            i_selec,
            Bclockx8
        );
    o_Bclkx8 <= Bclockx8;

    divcount8 : entity work.counter3bit(Structural)
        port map (
            '1',
            Bclockx8,
            i_reset,
            Bclock
        );

    o_Bclk <= Bclock(2) and Bclock(1) and Bclock(0);

end;
