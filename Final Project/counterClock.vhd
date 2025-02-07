library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity counterClock is
    Port (
        i_CTRload : in std_logic;
        i_CTRinc : in std_logic;
        i_CTRSEL : in std_logic;
        i_CLK : in std_logic;
        o_c : out std_logic
    );
end counterClock;

architecture struct of counterClock is
    signal muxout, COUNT: std_logic_vector(11 downto 0);

begin
    counter: entity work.leftShiftRegister12bit(struct)
        port map (
            i_CTRload,
            i_CTRinc,
            i_CLK,
            muxout,
            COUNT
        );

    mux: entity work.mux2x112bit(struct)
        port map (
            "111111000000", 
            "111111111110", 
            i_CTRSEL, 
            muxout
        );

    o_c <= COUNT(11);

end struct;
