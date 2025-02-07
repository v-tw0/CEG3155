library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TransmitterTop is
    Port (
        i_Greset, i_CLK: in std_logic;
        i_UARTselect, i_TDRload, i_TDRE: in std_logic;
        i_TDRin: in std_logic_vector(7 downto 0);
        o_TxD: out std_logic;
        o_TDREload, o_TDREin: out std_logic
    );
end TransmitterTop;

architecture struct of TransmitterTop is
    signal o_TDRout, o_TSRout: std_logic_vector(7 downto 0);
    signal o_TxDFFload, o_TxDFFset, o_TxDFFSEL, o_TSRload, o_TSRshiftR, o_TSRshiftout, o_TxDFFMUXout: std_logic;
begin
    TDR: entity work.register8bit(struct)
        port map(i_TDRload, i_CLK, i_TDRin, o_TDRout);

    TSR: entity work.TSR(struct)
        port map(o_TSRload, o_TSRshiftR, i_CLK, o_TDRout, o_TSRout, o_TSRshiftout);

    TxDFFMUX: entity work.mux2x18bit(struct)
        port map(o_TxDFFset, o_TSRshiftout, o_TxDFFSEL, o_TxDFFMUXout);

    TxDFF: entity work.ENDFF(struct)
        port map(o_TxDFFMUXout, o_TxDFFload, i_CLK, o_TxD);

    Controller: entity work.TransmitterController(struct)
        port map(i_Greset, i_CLK, i_UARTselect, i_TDRE, o_TDREload, o_TDREin, o_TxDFFload, o_TxDFFset, o_TxDFFSEL, o_TSRload, o_TSRshiftR);

end struct;
