library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TransmitterTB is
end TransmitterTB;

architecture Behavioral of TransmitterTB is
    signal CLK: std_logic;
    signal Greset: std_logic := '1';
    signal TDRload: std_logic := '1';
    signal TDRE: std_logic;
    signal TDRin: std_logic_vector(7 downto 0) := "01110110";
    signal TxD: std_logic;
    signal TDREload, TDREin: std_logic;
    signal UARTselect: std_logic := '1';
    
    signal forcelowTDRE: std_logic := '0';
    signal muxsignal: std_logic;
begin
    -- clock
    CLK_process: process is
        begin
    
            CLK <= '0';
            wait for 50 ns;
            CLK <= '1';
            wait for 50 ns;
        end process;

    forcelowTDRE <= '1' after 100 ns;

    transmitter: entity work.Transmitter(struct)
        port map(Greset, CLK, UARTselect, TDRload, TDRE, TDRin, TxD, TDREload, TDREin);

    TDRE_reg: entity work.ENDFF(struct)
        port map(muxsignal, TDREload, CLK, TDRE);
        
    mux: entity work.MUX2to1(struct)
        port map(TDREin, '0', forcelowTDRE, muxsignal);
        

end Behavioral;
