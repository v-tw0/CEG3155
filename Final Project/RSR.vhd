library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RSR is
    port (
        i_LOAD, i_SHIFTR, i_CLK, i_ASin: in std_logic;
        i_INPUT: in std_logic_vector(7 downto 0);
        o_OUTPUT: out std_logic_vector(7 downto 0)
    );
end RSR;

architecture struct of RSR is
    signal o_signalENDFF: std_logic_vector(7 downto 0);
    signal o_signalMUX: std_logic_vector(7 downto 0);
    signal o_signalQshift: std_logic_vector(7 downto 0);
begin

    o_signalQshift(6 downto 0) <= o_signalENDFF(7 downto 1);
    o_signalQshift(7) <= i_ASin;

    ENDFF_0: entity work.ENDFF(struct)
        port map(o_signalMUX(0), i_LOAD, i_CLK, o_signalENDFF(0));
    ENDFF_1: entity work.ENDFF(struct)
        port map(o_signalMUX(1), i_LOAD, i_CLK, o_signalENDFF(1));
    ENDFF_2: entity work.ENDFF(struct)
        port map(o_signalMUX(2), i_LOAD, i_CLK, o_signalENDFF(2));
    ENDFF_3: entity work.ENDFF(struct)
        port map(o_signalMUX(3), i_LOAD, i_CLK, o_signalENDFF(3));
    ENDFF_4: entity work.ENDFF(struct)
        port map(o_signalMUX(4), i_LOAD, i_CLK, o_signalENDFF(4));
    ENDFF_5: entity work.ENDFF(struct)
        port map(o_signalMUX(5), i_LOAD, i_CLK, o_signalENDFF(5));
    ENDFF_6: entity work.ENDFF(struct)
        port map(o_signalMUX(6), i_LOAD, i_CLK, o_signalENDFF(6));
    ENDFF_7: entity work.ENDFF(struct)
        port map(o_signalMUX(7), i_LOAD, i_CLK, o_signalENDFF(7));
    
    MUX2to1_8b: entity work.mux2x18bit(struct)
        port map(i_INPUT, o_signalQshift, i_SHIFTR, o_signalMUX);
    
    o_OUTPUT <= o_signalENDFF; 
end struct;
