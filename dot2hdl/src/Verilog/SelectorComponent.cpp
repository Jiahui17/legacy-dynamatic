/*
 * SelectorComponent.cpp
 *
 *  Created on: 31-Jul-2021
 *      Author: madhur
 */


#include "ComponentClass.h"
#include <cmath>

//Subclass for Entry type component
SelectorComponent::SelectorComponent(Component& c){
	index = c.index;
	moduleName = "selector_node";
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

//<Cond, Data>
std::string SelectorComponent::getVerilogParameters(){
	std::string ret;

	int amount_of_bbs = nodes[index].orderings.size();
	int bb_id_info_size = amount_of_bbs <= 1 ? 1 : (int)ceil(log2(amount_of_bbs));
	int max_shared_components = -1;
	for(auto ordering_per_bb : nodes[index].orderings){
		int size = ordering_per_bb.size();
		if(max_shared_components < size){
			max_shared_components = size;
		}
	}
	int bb_count_info_size = max_shared_components <= 1 ? 1 : ceil(log2(max_shared_components));

	ret += "#(.INPUTS(" + std::to_string(in.size - amount_of_bbs) + "), .OUTPUTS(" + std::to_string(out.size) + "), .COND_SIZE(" + std::to_string(out.output[out.size - 1].bit_size) + "), ";
	ret += ".DATA_IN_SIZE(" + std::to_string(in.input[0].bit_size == 0 ? 1 : in.input[0].bit_size) + "), ";
	ret += ".DATA_OUT_SIZE(" + std::to_string(out.output[0].bit_size == 0 ? 1 : out.output[0].bit_size) + "), \n";
	ret += "\t\t.AMOUNT_OF_BB_IDS(" + std::to_string(amount_of_bbs) + "), ";
	ret += ".AMOUNT_OF_SHARED_COMPONENT(" + std::to_string(max_shared_components) + "), ";
	ret += ".BB_ID_INFO_SIZE(" + std::to_string(bb_id_info_size) + "), ";
	ret += ".BB_COUNT_INFO_SIZE(" + std::to_string(bb_count_info_size) + ")) ";
	//0 data size will lead to negative port length in verilog code. So 0 data size has to be made 1.
	return ret;
}


void SelectorComponent::setInputPortBus(){
	InputConnection inConn;

	//First create data_in bus
	inputPortBus = ".data_in_bus({";
	//Special for Selector
	for(int i = nodes[i].inputs.size - nodes[i].orderings.size() - 1; i >= 0; i--){
		inConn = inputConnections[i];
		inputPortBus += inConn.data + ", ";
	}
	inputPortBus = inputPortBus.erase(inputPortBus.size() - 2, 2);//This is needed to remove extra comma and space after bus is populated
	inputPortBus += "}), ";

	//Now create valid_in bus
	inputPortBus += ".valid_in_bus({";
	//Special for Selector
	for(int i = nodes[i].inputs.size - nodes[i].orderings.size() - 1; i >= 0; i--){
		inConn = inputConnections[i];
		inputPortBus += inConn.valid + ", ";
	}
	inputPortBus = inputPortBus.erase(inputPortBus.size() - 2, 2);//This is needed to remove extra comma and space after bus is populated
	inputPortBus += "}), ";

	//Now create ready_in bus
	inputPortBus += ".ready_in_bus({";
	//Special for Selector
	for(int i = nodes[i].inputs.size - nodes[i].orderings.size() - 1; i >= 0; i--){
		inConn = inputConnections[i];
		inputPortBus += inConn.ready + ", ";
	}
	inputPortBus = inputPortBus.erase(inputPortBus.size() - 2, 2);//This is needed to remove extra comma and space after bus is populated
	inputPortBus += "}), ";



//Additional Input Ports for Selector:
	//Create bbInfoData
	inputPortBus = ".bbInfoData({";
	//Special for Selector
	for(int i = nodes[i].inputs.size - 1; i >= nodes[i].inputs.size - nodes[i].orderings.size(); i--){
		inConn = inputConnections[i];
		inputPortBus += inConn.data + ", ";
	}
	inputPortBus = inputPortBus.erase(inputPortBus.size() - 2, 2);//This is needed to remove extra comma and space after bus is populated
	inputPortBus += "}), ";

	//Now create bbInfoPValid bus
	inputPortBus += ".bbInfoPValid({";
	//Special for Selector
	for(int i = nodes[i].inputs.size - 1; i >= nodes[i].inputs.size - nodes[i].orderings.size(); i--){
		inConn = inputConnections[i];
		inputPortBus += inConn.valid + ", ";
	}
	inputPortBus = inputPortBus.erase(inputPortBus.size() - 2, 2);//This is needed to remove extra comma and space after bus is populated
	inputPortBus += "}), ";

	//Now create bbInfoReady bus
	inputPortBus += ".bbInfoReady({";
	//Special for Selector
	for(int i = nodes[i].inputs.size - 1; i >= nodes[i].inputs.size - nodes[i].orderings.size(); i--){
		inConn = inputConnections[i];
		inputPortBus += inConn.ready + ", ";
	}
	inputPortBus = inputPortBus.erase(inputPortBus.size() - 2, 2);//This is needed to remove extra comma and space after bus is populated
	inputPortBus += "}), ";


	//TODO add bbOrderingData
}
