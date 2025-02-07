library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ReceiverTB is
end ReceiverTB;

architecture Behavioral of ReceiverTB is
    signal i_CLK: std_logic;
    signal i_Greset: std_logic := '1';
    signal o_RDRout: std_logic_vector(7 downto 0);
    signal i_RDRF: std_logic := '0';
    signal i_RxD: std_logic := '1';
    signal o_RDRFload, o_RDRFin: std_logic;
    signal o_FEload, o_FEin, o_OEload, o_OEin: std_logic;
begin
    -- clock
    i_CLK_process: process is
        begin
            i_CLK <= '0';
            wait for 50 ns;
            i_CLK <= '1';
            wait for 50 ns;
        end process;

    receiver: entity work.ReceiverTop(struct)
        port map(i_Greset, i_CLK, i_RxD, i_RDRF, o_RDRFload, o_RDRFin, o_FEload, o_FEin, o_OEload, o_OEin, o_RDRout);

    RDRF_reg: entity work.ENDFF(struct)
        port map(o_RDRFin, o_RDRFload, i_CLK, i_RDRF);

end Behavioral;
