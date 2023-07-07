----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:14:26 02/21/2023 
-- Design Name: 
-- Module Name:    firfilter - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity firfilter is
	port (clk                             :   IN    std_logic;
         filter_in1                      :   IN    std_logic_vector(7 DOWNTO 0); -- sfix16_En15 
			filter_in2                      :   IN    std_logic_vector(7 DOWNTO 0); -- sfix16_En15
			filter_in3                      :   IN    std_logic_vector(7 DOWNTO 0);
			filter_in4                      :   IN    std_logic_vector(7 DOWNTO 0);
			filter_in5                      :   IN    std_logic_vector(7 DOWNTO 0); -- sfix16_En15 
			filter_in6                      :   IN    std_logic_vector(7 DOWNTO 0); -- sfix16_En15
			filter_in7                      :   IN    std_logic_vector(7 DOWNTO 0);
			filter_in8                      :   IN    std_logic_vector(7 DOWNTO 0);
			filter_out                     :   OUT   std_logic_vector(63 DOWNTO 0)
			);
end firfilter;

architecture Behavioral of firfilter is

component booth_multiplier8 is
		GENERIC (x : INTEGER:=8;
		 y : INTEGER:=8);
	
		PORT(m : IN STD_LOGIC_VECTOR(x - 1 DOWNTO 0);
	     r : IN STD_LOGIC_VECTOR(y - 1 DOWNTO 0);
		  clk: IN STD_LOGIC;
	     result : OUT STD_LOGIC_VECTOR(x + y - 1 DOWNTO 0));
end component;

component booth_multiplier16 is
		GENERIC (x : INTEGER:=16;
		 y : INTEGER:=16);
	
		PORT(m : IN STD_LOGIC_VECTOR(x - 1 DOWNTO 0);
	     r : IN STD_LOGIC_VECTOR(y - 1 DOWNTO 0);
		  clk: IN STD_LOGIC;
	     result : OUT STD_LOGIC_VECTOR(x + y - 1 DOWNTO 0));
end component;

component booth_multiplier32 is
		GENERIC (x : INTEGER:=32;
		 y : INTEGER:=32);
	
		PORT(m : IN STD_LOGIC_VECTOR(x - 1 DOWNTO 0);
	     r : IN STD_LOGIC_VECTOR(y - 1 DOWNTO 0);
		  clk: IN STD_LOGIC;
	     result : OUT STD_LOGIC_VECTOR(x + y - 1 DOWNTO 0));
end component;

SIGNAL filter_in_regtype1                : std_logic_vector(7 downto 0); -- sfix16_En15
SIGNAL filter_in_regtype2                : std_logic_vector(7 downto 0); -- sfix16_En15
SIGNAL filter_in_regtype3                : std_logic_vector(7 downto 0);
SIGNAL filter_in_regtype4                : std_logic_vector(7 downto 0);
SIGNAL filter_in_regtype5                : std_logic_vector(7 downto 0); -- sfix16_En15
SIGNAL filter_in_regtype6                : std_logic_vector(7 downto 0); -- sfix16_En15
SIGNAL filter_in_regtype7                : std_logic_vector(7 downto 0);
SIGNAL filter_in_regtype8                : std_logic_vector(7 downto 0);

SIGNAL mul_temp_11                       : std_logic_vector(15 DOWNTO 0); -- sfix32_En31
SIGNAL mul_temp_12                       : std_logic_vector(15 DOWNTO 0); -- sfix32_En31
SIGNAL mul_temp_13                       : std_logic_vector(15 DOWNTO 0); -- sfix32_En31
SIGNAL mul_temp_14                       : std_logic_vector(15 DOWNTO 0); -- sfix32_En31

SIGNAL mul_temp_21                       : std_logic_vector(31 DOWNTO 0); -- sfix32_En31
SIGNAL mul_temp_22                       : std_logic_vector(31 DOWNTO 0); -- sfix32_En31

SIGNAL mul_temp_31                       : std_logic_vector(63 DOWNTO 0); -- sfix32_En31

begin

		filter_in_regtype1 <= std_logic_vector(filter_in1);
		filter_in_regtype2 <= std_logic_vector(filter_in2);
		filter_in_regtype3 <= std_logic_vector(filter_in3);
		filter_in_regtype4 <= std_logic_vector(filter_in4);		
		filter_in_regtype5 <= std_logic_vector(filter_in5);
		filter_in_regtype6 <= std_logic_vector(filter_in6);
		filter_in_regtype7 <= std_logic_vector(filter_in7);
		filter_in_regtype8 <= std_logic_vector(filter_in8);


		x1: booth_multiplier8 generic map(x=>8,y=>8) port map (filter_in_regtype1,filter_in_regtype2,clk,mul_temp_11);
		x2: booth_multiplier8 generic map(x=>8,y=>8) port map (filter_in_regtype3,filter_in_regtype4,clk,mul_temp_12);
		x3: booth_multiplier8 generic map(x=>8,y=>8) port map (filter_in_regtype5,filter_in_regtype6,clk,mul_temp_13);
		x4: booth_multiplier8 generic map(x=>8,y=>8) port map (filter_in_regtype7,filter_in_regtype8,clk,mul_temp_14);
		
		x5: booth_multiplier16 generic map(x=>16,y=>16) port map (mul_temp_11,mul_temp_12,clk,mul_temp_21);
		x6: booth_multiplier16 generic map(x=>16,y=>16) port map (mul_temp_13,mul_temp_14,clk,mul_temp_22);
 
		y: booth_multiplier32 generic map(x=>32,y=>32) port map (mul_temp_21,mul_temp_22,clk,mul_temp_31);	

		filter_out <= std_logic_vector(mul_temp_31);
end Behavioral;

