library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity leftShiftRegister12bit is
    port (
        i_LOAD : in std_logic;
        i_SHIFTL : in std_logic;
        i_CLK : in std_logic;
        i_INPUT : in std_logic_vector(11 downto 0);
        o_OUTPUT : out std_logic_vector(11 downto 0)
    );
end leftShiftRegister12bit;

architecture struct of leftShiftRegister12bit is

    signal signalENDFF : std_logic_vector(11 downto 0);
    signal signalMUX : std_logic_vector(11 downto 0);
    signal signalQshift : std_logic_vector(11 downto 0);

begin

    -- Shift signal logic
    signalQshift(11 downto 1) <= signalENDFF(10 downto 0);
    signalQshift(0) <= '0';

    ENDFF_0 : entity work.ENDFF(struct)
        port map (signalMUX(0), i_LOAD, i_CLK, signalENDFF(0));

    ENDFF_1 : entity work.ENDFF(struct)
        port map (signalMUX(1), i_LOAD, i_CLK, signalENDFF(1));

    ENDFF_2 : entity work.ENDFF(struct)
        port map (signalMUX(2), i_LOAD, i_CLK, signalENDFF(2));

    ENDFF_3 : entity work.ENDFF(struct)
        port map (signalMUX(3), i_LOAD, i_CLK, signalENDFF(3));

    ENDFF_4 : entity work.ENDFF(struct)
        port map (signalMUX(4), i_LOAD, i_CLK, signalENDFF(4));

    ENDFF_5 : entity work.ENDFF(struct)
        port map (signalMUX(5), i_LOAD, i_CLK, signalENDFF(5));

    ENDFF_6 : entity work.ENDFF(struct)
        port map (signalMUX(6), i_LOAD, i_CLK, signalENDFF(6));

    ENDFF_7 : entity work.ENDFF(struct)
        port map (signalMUX(7), i_LOAD, i_CLK, signalENDFF(7));

    ENDFF_8 : entity work.ENDFF(struct)
        port map (signalMUX(8), i_LOAD, i_CLK, signalENDFF(8));

    ENDFF_9 : entity work.ENDFF(struct)
        port map (signalMUX(9), i_LOAD, i_CLK, signalENDFF(9));

    ENDFF_10 : entity work.ENDFF(struct)
        port map (signalMUX(10), i_LOAD, i_CLK, signalENDFF(10));

    ENDFF_11 : entity work.ENDFF(struct)
        port map (signalMUX(11), i_LOAD, i_CLK, signalENDFF(11));

    -- SHIFTL is the select to determine the register's input
    -- o_OUTPUT <= left shifted signal if i_SHIFTL is 1
    -- o_OUTPUT <= i_INPUT signal if i_SHIFTL is 0
    MUX2to1_12b : entity work.mux2x112bit(struct)
        port map (i_INPUT, signalQshift, i_SHIFTL, signalMUX);

    o_OUTPUT <= signalENDFF;

end struct;
