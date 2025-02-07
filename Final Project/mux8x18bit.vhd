library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux8x18bit is
 Port (
    i_IN0, i_IN1, i_IN2, i_IN3, i_IN4, i_IN5, i_IN6, i_IN7: in std_logic_vector(7 downto 0);
    i_SEL: in std_logic_vector(2 downto 0);
    o_output: out std_logic_vector(7 downto 0)
 );
end mux8x18bit;

architecture struct of mux8x18bit is
    signal MUX1out, MUX2out: std_logic_vector(7 downto 0);
begin
    MUX1: entity work.mux4x18bit(struct)
        port map(i_IN0, i_IN2, i_IN1, i_IN3, i_SEL(1), i_SEL(0), MUX1out);

    MUX2: entity work.mux4x18bit(struct)
        port map(i_IN4, i_IN6, i_IN5, i_IN7, i_SEL(1), i_SEL(0), MUX2out);

    MUX3: entity work.mux2x18bit(struct)
        port map(MUX1out, MUX2out, i_SEL(2), o_output);
end struct;
