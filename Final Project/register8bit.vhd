library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity register8bit is
    port(
        i_LOAD, i_CLK: in std_logic;
        i_INPUT: in std_logic_vector(7 downto 0);
        o_OUTPUT: out std_logic_vector(7 downto 0)
    );
end register8bit;

architecture struct of register8bit is
    signal o_signalENDFF: std_logic_vector(7 downto 0);
begin
    ENDFF_0: entity work.ENDFF(struct)
        port map(i_INPUT(0), i_LOAD, i_CLK, o_signalENDFF(0));
    ENDFF_1: entity work.ENDFF(struct)
        port map(i_INPUT(1), i_LOAD, i_CLK, o_signalENDFF(1));
    ENDFF_2: entity work.ENDFF(struct)
        port map(i_INPUT(2), i_LOAD, i_CLK, o_signalENDFF(2));
    ENDFF_3: entity work.ENDFF(struct)
        port map(i_INPUT(3), i_LOAD, i_CLK, o_signalENDFF(3));
    ENDFF_4: entity work.ENDFF(struct)
        port map(i_INPUT(4), i_LOAD, i_CLK, o_signalENDFF(4));
    ENDFF_5: entity work.ENDFF(struct)
        port map(i_INPUT(5), i_LOAD, i_CLK, o_signalENDFF(5));
    ENDFF_6: entity work.ENDFF(struct)
        port map(i_INPUT(6), i_LOAD, i_CLK, o_signalENDFF(6));
    ENDFF_7: entity work.ENDFF(struct)
        port map(i_INPUT(7), i_LOAD, i_CLK, o_signalENDFF(7));
    o_OUTPUT <= o_signalENDFF;
end struct;
