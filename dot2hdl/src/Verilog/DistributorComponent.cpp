/*
 * DistributorComponent.cpp
 *
 *  Created on: 31-Jul-2021
 *      Author: madhur
 */



#include "ComponentClass.h"

//Subclass for Entry type component
DistributorComponent::DistributorComponent(Component& c){
	index = c.index;
	moduleName = "distributor_node";
	name = c.name;
	instanceName = moduleName + "_" + name;
	type = c.type;
	bbID = c.bbID;
	op = c.op;
	in = c.in;
	out = c.out;
	delay = c.delay;
	latency = c.latency;
	II = c.II;
	slots = c.slots;
	transparent = c.transparent;
	value = c.value;
	io = c.io;
	inputConnections = c.inputConnections;
	outputConnections = c.outputConnections;

	clk = c.clk;
	rst = c.rst;
}


std::string DistributorComponent::getVerilogParameters(){
	std::string ret;

	ret += "#(.INPUTS(" + std::to_string(in.size) + "), .OUTPUTS(" + std::to_string(out.size) + "), ";
	ret += ".DATA_IN_SIZE(" + std::to_string(in.input[0].bit_size == 0 ? 1 : in.input[0].bit_size) + "), ";
	ret += ".COND_SIZE(" + std::to_string(in.input[1].bit_size == 0 ? 1 : in.input[1].bit_size) + "), ";
	ret += ".DATA_OUT_SIZE(" + std::to_string(out.output[0].bit_size == 0 ? 1 : out.output[0].bit_size) + ")) ";
	//0 data size will lead to negative port length in verilog code. So 0 data size has to be made 1.
	return ret;
}
