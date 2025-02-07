library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SCSR is
    Port (
        i_CLK: in std_logic;
        i_TDREin, i_RDRFin, i_OEin, i_FEin: in std_logic;
        i_TDREload, i_RDRFload, i_OEload, i_FEload: in std_logic;
        o_TDREout, o_RDRFout: out std_logic;
        o_SCSRout: out std_logic_vector(7 downto 0)
    );
end SCSR;

architecture struct of SCSR is
    signal o_signalENDFF: std_logic_vector(7 downto 0);
begin
    FE: entity work.ENDFF(struct)
        port map(i_FEin, i_FEload, i_CLK, o_signalENDFF(0));
    OE: entity work.ENDFF(struct)
        port map(i_OEin, i_OEload, i_CLK, o_signalENDFF(1));
    ENDFF_2: entity work.ENDFF(struct)
        port map('0', '0', i_CLK, o_signalENDFF(2));
    ENDFF_3: entity work.ENDFF(struct)
        port map('0', '0', i_CLK, o_signalENDFF(3));
    ENDFF_4: entity work.ENDFF(struct)
        port map('0', '0', i_CLK, o_signalENDFF(4));
    ENDFF_5: entity work.ENDFF(struct)
        port map('0', '0', i_CLK, o_signalENDFF(5));
    RDRF: entity work.ENDFF(struct)
        port map(i_RDRFin, i_RDRFload, i_CLK, o_signalENDFF(6));
    TDRE: entity work.ENDFF(struct)
        port map(i_TDREin, i_TDREload, i_CLK, o_signalENDFF(7));
    
    o_SCSRout <= o_signalENDFF;
    o_TDREout <= o_signalENDFF(7);
    o_RDRFout <= o_signalENDFF(6);

end struct;
