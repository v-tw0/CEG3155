library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux4x18bit is
    port(
        i_IN0, i_IN1, i_IN2, i_IN3: in std_logic_vector(7 downto 0);
        i_Sel1, i_Sel2: in std_logic;
        o_OUTPUT: out std_logic_vector(7 downto 0)
    );
end mux4x18bit;

architecture struct of mux4x18bit is
    signal signalMUX1, signalMUX2: std_logic_vector(7 downto 0);
begin
    mux1: entity work.mux2x18bit(struct)
        port map(i_IN0, i_IN1, i_Sel1, signalMUX1);
    mux2: entity work.mux2x18bit(struct)
        port map(i_IN2, i_IN3, i_Sel1, signalMUX2);
    mux3: entity work.mux2x18bit(struct)
        port map(signalMUX1, signalMUX2, i_Sel2, o_OUTPUT);
end struct;
