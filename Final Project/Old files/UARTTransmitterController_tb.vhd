library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity UARTTransmitterController_tb is
end entity;

architecture Testbench of UARTTransmitterController_tb is
    -- Component Declaration for the Unit Under Test (UUT)
    component UARTTransmitterController
        port (
            GReset: in std_logic;
            CLK: in std_logic;
            SEND: in std_logic;
            
            TDRE_LOAD: out std_logic;
            TDRE_WRITE: out std_logic;
            
            TDR_LOAD: out std_logic;
            
            TSR_LOAD: out std_logic;
            TSR_SHIFT: out std_logic;
            
            TxDFF_SET: out std_logic; 
            TxDFF_LOAD: out std_logic
        );
    end component;
    
    -- Signal Declarations
    signal GReset: std_logic := '0';
    signal CLK: std_logic := '0';
    signal SEND: std_logic := '0';
    
    signal TDRE_LOAD: std_logic;
    signal TDRE_WRITE: std_logic;
    signal TDR_LOAD: std_logic;
    signal TSR_LOAD: std_logic;
    signal TSR_SHIFT: std_logic;
    signal TxDFF_SET: std_logic;
    signal TxDFF_LOAD: std_logic;
    
    -- Clock period definition
    constant CLK_PERIOD: time := 20 ns;

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: UARTTransmitterController
        port map (
            GReset => GReset,
            CLK => CLK,
            SEND => SEND,
            
            TDRE_LOAD => TDRE_LOAD,
            TDRE_WRITE => TDRE_WRITE,
            
            TDR_LOAD => TDR_LOAD,
            
            TSR_LOAD => TSR_LOAD,
            TSR_SHIFT => TSR_SHIFT,
            
            TxDFF_SET => TxDFF_SET,
            TxDFF_LOAD => TxDFF_LOAD
        );
    
    -- Clock generation process
    CLK_process: process
    begin
        while true loop
            CLK <= '0';
            wait for CLK_PERIOD / 2;
            CLK <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
    end process;

    -- Stimulus process
    Stimulus_process: process
    begin
        -- Reset the circuit
        GReset <= '0';
        wait for 50 ns;
        GReset <= '1';
        
        -- Test SEND signal triggering
        SEND <= '1';
        wait for 100 ns;
        SEND <= '0';
        
        -- Wait for some time and observe the outputs
        wait for 200 ns;
        
        -- Test another SEND pulse
        SEND <= '1';
        wait for 100 ns;
        SEND <= '0';
        
        -- Wait for observation
        wait for 200 ns;
        
        -- End simulation
        wait;
    end process;
end architecture Testbench;
