library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SCCR is
    Port (
        i_CLK: in std_logic;
        i_SCCRin: in std_logic_vector(7 downto 0);
        i_SCCRload: in std_logic;
        o_SCCRout: out std_logic_vector(7 downto 0);
        o_SELout: out std_logic_vector(2 downto 0);
        o_TIE, o_RIE: out std_logic
    );
end SCCR;

architecture struct of SCCR is
    signal o_signalENDFF: std_logic_vector(7 downto 0);
begin
    
    -- SEL:
    ENDFF_0: entity work.ENDFF(struct)
        port map(i_SCCRin(0), i_SCCRload, i_CLK, o_signalENDFF(0));
    ENDFF_1: entity work.ENDFF(struct)
        port map(i_SCCRin(1), i_SCCRload, i_CLK, o_signalENDFF(1));
    ENDFF_2: entity work.ENDFF(struct)
        port map(i_SCCRin(2), i_SCCRload, i_CLK, o_signalENDFF(2));

    ENDFF_3: entity work.ENDFF(struct)
        port map(i_SCCRin(3), i_SCCRload, i_CLK, o_signalENDFF(3));
    ENDFF_4: entity work.ENDFF(struct)
        port map(i_SCCRin(4), i_SCCRload, i_CLK, o_signalENDFF(4));
    ENDFF_5: entity work.ENDFF(struct)
        port map(i_SCCRin(5), i_SCCRload, i_CLK, o_signalENDFF(5));
    ENDFF_6: entity work.ENDFF(struct)
        port map(i_SCCRin(6), i_SCCRload, i_CLK, o_signalENDFF(6));
    ENDFF_7: entity work.ENDFF(struct)
        port map(i_SCCRin(7), i_SCCRload, i_CLK, o_signalENDFF(7));
    
    o_SCCRout <= o_signalENDFF;
    o_SELout <= o_signalENDFF(2 downto 0);
    o_TIE <= o_signalENDFF(7);
    o_RIE <= o_signalENDFF(6);

end struct;
