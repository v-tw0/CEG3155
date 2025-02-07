library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ReceiverTop is
 Port (
    i_Greset, i_CLK: in std_logic;
    i_RxD, i_RDRF: in std_logic;
    o_RDRFload, o_RDRFin: out std_logic;
    o_FEload, o_FEin: out std_logic;
    o_OEload, o_OEin: out std_logic;
    o_RDRout: out std_logic_vector(7 downto 0)
 );
end ReceiverTop;

architecture struct of ReceiverTop is
    signal o_RSRload, o_RSRshiftR, o_RDRload: std_logic;
    signal o_RSRout: std_logic_vector(7 downto 0);
begin
    o_RDR: entity work.register8bit(struct)
        port map(o_RDRload, i_CLK, o_RSRout, o_RDRout);

    o_RSR: entity work.RSR(struct)
        port map(o_RSRload, o_RSRshiftR, i_CLK, i_RxD, "00000000", o_RSRout);

    o_Controller: entity work.ReceiverController(struct)
        port map(i_Greset, i_CLK, i_RxD, i_RDRF, o_RSRload, o_RSRshiftR, o_RDRload, o_RDRFload, o_RDRFin, o_FEload, o_FEin, o_OEload, o_OEin);

end ;
