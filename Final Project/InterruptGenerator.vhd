library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity InterruptGenerator is
 Port (
    TIE, RIE, RDRF, OE, TDRE: in std_logic;
    IRQ: out std_logic_vector(1 downto 0)
 );
end InterruptGenerator;

architecture struct of InterruptGenerator is

begin
    -- IRQ(0) = receiver interrupt
    IRQ(0) <= RIE and (RDRF or OE);

    -- IRQ(1) = transmitter interrupt
    IRQ(1) <= TIE and TDRE;

end ;
