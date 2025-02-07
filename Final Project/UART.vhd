library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity UART is
    Port (
        i_Greset, i_CLK: in std_logic;
        i_RxD, i_UARTselect, i_R: in std_logic;
        i_ADDR: in std_logic_vector(1 downto 0);
        i_DATA_BUS_IN: in std_logic_vector(7 downto 0);
        o_DATA_BUS_OUT: out std_logic_vector(7 downto 0);
        o_TxD: out std_logic;
        o_IRQ: out std_logic_vector(1 downto 0)
    );
end UART;

architecture struct of UART is
    signal o_BCLK, o_BCLKx8: std_logic;
    signal o_BRGSEL: std_logic_vector(2 downto 0);
    signal o_RDRout, o_SCSRout, o_SCCRout: std_logic_vector(7 downto 0);
    signal o_AD_TDRload, o_AD_SCCRload: std_logic;
    signal o_AD_TDRin, o_AD_SCCRin: std_logic_vector(7 downto 0);
    signal o_AD_TDREload, o_AD_TDREin: std_logic;
    signal o_AD_RDRFload, o_AD_RDRFin: std_logic;
    signal o_TDREload, o_TDREin, o_RDRFload, o_RDRFin, o_OEin, o_FEin, o_OEload, o_FEload, o_TDREout, o_RDRFout: std_logic;
    
    signal o_TC_TDREload: std_logic;
    signal o_TC_TDREin: std_logic;
    signal o_RC_RDRFload: std_logic;
    signal o_RC_RDRFin: std_logic;

    signal o_TIE, o_RIE: std_logic;
begin

    SCCR: entity work.SCCR(struct)
        port map(i_CLK, o_AD_SCCRin, o_AD_SCCRload, o_SCCRout, o_BRGSEL, o_TIE, o_RIE);

    SCSR: entity work.SCSR(struct)
        port map(o_BCLKx8, o_TDREin, o_RDRFin, o_OEin, o_FEin, o_TDREload, o_RDRFload, o_OEload, o_FEload, o_TDREout, o_RDRFout, o_SCSRout);

    SCSRcontrol: entity work.SCSRcontrol(struct)
        port map(i_UARTselect, o_TC_TDREload, o_AD_TDREload, o_TC_TDREin, o_AD_TDREin, o_RC_RDRFload, o_AD_RDRFload, o_RC_RDRFin, o_AD_RDRFin, o_TDREload, o_TDREin, o_RDRFload, o_RDRFin);

    BaudRateGen: entity work.BaudRateGenerator(struct)
        port map(i_Greset, i_CLK, o_BRGSEL, o_BCLK, o_BCLKx8);

    AD: entity work.UARTController(struct)
        port map(i_CLK, i_ADDR, i_R, i_UARTselect, o_RDRout, o_SCSRout, o_SCCRout, i_DATA_BUS_IN, o_DATA_BUS_OUT, o_AD_TDRload, o_AD_SCCRload, o_AD_TDRin, o_AD_SCCRin, o_AD_TDREload, o_AD_TDREin, o_AD_RDRFload, o_AD_RDRFin);

    Transmitter: entity work.Transmitter(struct)
        port map(i_Greset, o_BCLK, i_UARTselect, o_AD_TDRload, o_TDREout, o_AD_TDRin, o_TxD, o_TC_TDREload, o_TC_TDREin);

    Receiver: entity work.ReceiverTop(struct)
        port map(i_Greset, o_BCLKx8, i_RxD, o_RDRFout, o_RC_RDRFload, o_RC_RDRFin, o_FEload, o_FEin, o_OEload, o_OEin, o_RDRout);

    InterruptGenerator: entity work.InterruptGenerator(struct)
        port map(o_TIE, o_RIE, o_RDRFout, o_SCSRout(1), o_TDREout, o_IRQ);

end struct;
