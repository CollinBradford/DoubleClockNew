----------------------------------------------------------------------------------
-- Company: Fermilab
-- Engineer: Collin Bradford
-- 
-- Create Date:    10:14:49 07/08/2016 
-- Design Name: 
-- Module Name:    data_send - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity data_send is
    Port ( rst : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           din : in  STD_LOGIC_VECTOR (63 downto 0);
           empty : in  STD_LOGIC;
           b_enable : in  STD_LOGIC;
           delay_time : in  STD_LOGIC_VECTOR(7 downto 0);
           b_data : out  STD_LOGIC_VECTOR (63 downto 0);
           b_data_we : out  STD_LOGIC);
end data_send;

architecture Behavioral of data_send is

signal count_delay : unsigned(7 downto 0);
signal delay_time_u : unsigned(7 downto 0);

begin

	delay_time_u <= unsigned(delay_time);
	
	process(clk, b_enable) 
	begin
		if(rst = '0') then
			if(empty = '0') then
				if(rising_edge(clk)) then
					b_data_we <= '0';
					
					count_delay <= count_delay + 1;
					if(count_delay >= delay_time_u) then
						count_delay <= (others => '0');
						b_data_we <= '1';
					end if;
				end if;
			end if;
		else--reset code here
		end if;
	end process;
	
	--b_data <= din;
	b_data(7 downto 0) <= din(63 downto 56);
	b_data(15 downto 8) <= din(55 downto 48);
	b_data(23 downto 16) <= din(47 downto 40);
	b_data(31 downto 24) <= din(39 downto 32);
	b_data(39 downto 32) <= din(31 downto 24);
	b_data(47 downto 40) <= din(23 downto 16);
	b_data(55 downto 48) <= din(15 downto 8);
	b_data(63 downto 56) <= din(7 downto 0);
	--This makes the data come out right for some reason.  Better to organize it here than on the coputer where it will take 
	--valuable clocks.  
	
end Behavioral;

