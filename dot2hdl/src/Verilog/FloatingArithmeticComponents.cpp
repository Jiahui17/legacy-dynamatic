/*
 * FloatingArithmeticComponents.cpp
 *
 *  Created on: 15-Jul-2021
 *      Author: madhur
 */

#include "ComponentClass.h"

std::string vivado_version = "7.1";

//Constructor for abstract class
FloatingArithmeticComponent::FloatingArithmeticComponent(Component& c){
	index = c.index;
	moduleName = c.moduleName;
	name = c.name;
	instanceName = c.instanceName;
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
	std::cout << "[INFO] from FloatingArithmeticComponent called constructor of: " << c.instanceName << std::endl;

	max_latency = 0x0fffffff;

	clk = c.clk;
	rst = c.rst;
}

//FADD Component:
FaddComponent::FaddComponent(Component& c) : FloatingArithmeticComponent(c){

	max_latency = 11;

	index = c.index;
	moduleName = "fadd_op";
	name = c.name;
	instanceName =  name;
	type = c.type;
	bbID = c.bbID;
	op = c.op;
	in = c.in;
	out = c.out;
	delay = c.delay;
	latency = c.latency <= max_latency ? latency : max_latency;
	II = c.II;
	slots = c.slots;
	transparent = c.transparent;
	value = c.value;
	io = c.io;
	inputConnections = c.inputConnections;
	outputConnections = c.outputConnections;
	std::cout << "[INFO] from FaddComponent called constructor of: " << c.instanceName << std::endl;

	clk = c.clk;
	rst = c.rst;

	dsp48_uage = "Full_Usage";
	add_sub = "Add";
	compare_operation = "Programmable";
	operation_type = "Add_Subtract";
};

//FSUB Component:
FsubComponent::FsubComponent(Component& c) : FloatingArithmeticComponent(c){

	max_latency = 11;

	index = c.index;
	moduleName = "fsub_op";
	name = c.name;
	instanceName =  name;
	type = c.type;
	bbID = c.bbID;
	op = c.op;
	in = c.in;
	out = c.out;
	delay = c.delay;
	latency = c.latency <= max_latency ? latency : max_latency;
	II = c.II;
	slots = c.slots;
	transparent = c.transparent;
	value = c.value;
	io = c.io;
	inputConnections = c.inputConnections;
	outputConnections = c.outputConnections;

	clk = c.clk;
	rst = c.rst;

	dsp48_uage = "Full_Usage";
	add_sub = "Subtract";
	compare_operation = "Programmable";
	operation_type = "Add_Subtract";
};

//FMUL Component:
FmulComponent::FmulComponent(Component& c) : FloatingArithmeticComponent(c){

	max_latency = 8;

	index = c.index;
	moduleName = "fmul_op";
	name = c.name;
	instanceName =  name;
	type = c.type;
	bbID = c.bbID;
	op = c.op;
	in = c.in;
	out = c.out;
	delay = c.delay;
	latency = c.latency <= max_latency ? latency : max_latency;
	II = c.II;
	slots = c.slots;
	transparent = c.transparent;
	value = c.value;
	io = c.io;
	inputConnections = c.inputConnections;
	outputConnections = c.outputConnections;


	clk = c.clk;
	rst = c.rst;

	dsp48_uage = "Full_Usage";
	add_sub = "Both";
	compare_operation = "Programmable";
	operation_type = "Multiply";
};

//FDIV Component:
FdivComponent::FdivComponent(Component& c) : FloatingArithmeticComponent(c){

	max_latency = 28;

	index = c.index;
	moduleName = "fdiv_op";
	name = c.name;
	instanceName =  name;
	type = c.type;
	bbID = c.bbID;
	op = c.op;
	in = c.in;
	out = c.out;
	delay = c.delay;
	latency = c.latency <= max_latency ? latency : max_latency;
	II = c.II;
	slots = c.slots;
	transparent = c.transparent;
	value = c.value;
	io = c.io;
	inputConnections = c.inputConnections;
	outputConnections = c.outputConnections;


	clk = c.clk;
	rst = c.rst;

	dsp48_uage = "No_Usage";
	add_sub = "Both";
	compare_operation = "Programmable";
	operation_type = "Divide";
};

//FOEQ Component:
FoeqComponent::FoeqComponent(Component& c) : FloatingArithmeticComponent(c){

	max_latency = 2;

	index = c.index;
	moduleName = "fcmp_oeq_op";
	name = c.name;
	instanceName =  name;
	type = c.type;
	bbID = c.bbID;
	op = c.op;
	in = c.in;
	out = c.out;
	delay = c.delay;
	latency = c.latency <= max_latency ? latency : max_latency;
	II = c.II;
	slots = c.slots;
	transparent = c.transparent;
	value = c.value;
	io = c.io;
	inputConnections = c.inputConnections;
	outputConnections = c.outputConnections;


	clk = c.clk;
	rst = c.rst;

	dsp48_uage = "No_Usage";
	add_sub = "Both";
	compare_operation = "Equal";
	operation_type = "Compare";
};

//FONE Component:
FoneComponent::FoneComponent(Component& c) : FloatingArithmeticComponent(c){

	max_latency = 2;

	index = c.index;
	moduleName = "fcmp_one_op";
	name = c.name;
	instanceName =  name;
	type = c.type;
	bbID = c.bbID;
	op = c.op;
	in = c.in;
	out = c.out;
	delay = c.delay;
	latency = c.latency <= max_latency ? latency : max_latency;
	II = c.II;
	slots = c.slots;
	transparent = c.transparent;
	value = c.value;
	io = c.io;
	inputConnections = c.inputConnections;
	outputConnections = c.outputConnections;


	clk = c.clk;
	rst = c.rst;

	dsp48_uage = "No_Usage";
	add_sub = "Both";
	compare_operation = "Not_Equal";
	operation_type = "Compare";
};

//FOGT Component:
FogtComponent::FogtComponent(Component& c) : FloatingArithmeticComponent(c){

	max_latency = 2;

	index = c.index;
	moduleName = "fcmp_ogt_op";
	name = c.name;
	instanceName =  name;
	type = c.type;
	bbID = c.bbID;
	op = c.op;
	in = c.in;
	out = c.out;
	delay = c.delay;
	latency = c.latency <= max_latency ? latency : max_latency;
	II = c.II;
	slots = c.slots;
	transparent = c.transparent;
	value = c.value;
	io = c.io;
	inputConnections = c.inputConnections;
	outputConnections = c.outputConnections;


	clk = c.clk;
	rst = c.rst;

	dsp48_uage = "No_Usage";
	add_sub = "Both";
	compare_operation = "Greater_Than";
	operation_type = "Compare";
};

//FOGE Component:
FogeComponent::FogeComponent(Component& c) : FloatingArithmeticComponent(c){

	max_latency = 2;

	index = c.index;
	moduleName = "fcmp_oge_op";
	name = c.name;
	instanceName =  name;
	type = c.type;
	bbID = c.bbID;
	op = c.op;
	in = c.in;
	out = c.out;
	delay = c.delay;
	latency = c.latency <= max_latency ? latency : max_latency;
	II = c.II;
	slots = c.slots;
	transparent = c.transparent;
	value = c.value;
	io = c.io;
	inputConnections = c.inputConnections;
	outputConnections = c.outputConnections;


	clk = c.clk;
	rst = c.rst;

	dsp48_uage = "No_Usage";
	add_sub = "Both";
	compare_operation = "Greater_Than_Or_Equal";
	operation_type = "Compare";
};

//FOLT Component:
FoltComponent::FoltComponent(Component& c) : FloatingArithmeticComponent(c){

	max_latency = 2;

	index = c.index;
	moduleName = "fcmp_olt_op";
	name = c.name;
	instanceName =  name;
	type = c.type;
	bbID = c.bbID;
	op = c.op;
	in = c.in;
	out = c.out;
	delay = c.delay;
	latency = c.latency <= max_latency ? latency : max_latency;
	II = c.II;
	slots = c.slots;
	transparent = c.transparent;
	value = c.value;
	io = c.io;
	inputConnections = c.inputConnections;
	outputConnections = c.outputConnections;


	clk = c.clk;
	rst = c.rst;

	dsp48_uage = "No_Usage";
	add_sub = "Both";
	compare_operation = "Less_Than";
	operation_type = "Compare";
};

//FOGE Component:
FoleComponent::FoleComponent(Component& c) : FloatingArithmeticComponent(c){

	max_latency = 2;

	index = c.index;
	moduleName = "fcmp_ole_op";
	name = c.name;
	instanceName =  name;
	type = c.type;
	bbID = c.bbID;
	op = c.op;
	in = c.in;
	out = c.out;
	delay = c.delay;
	latency = c.latency <= max_latency ? latency : max_latency;
	II = c.II;
	slots = c.slots;
	transparent = c.transparent;
	value = c.value;
	io = c.io;
	inputConnections = c.inputConnections;
	outputConnections = c.outputConnections;


	clk = c.clk;
	rst = c.rst;

	dsp48_uage = "No_Usage";
	add_sub = "Both";
	compare_operation = "Less_Than_Or_Equal";
	operation_type = "Compare";
};


///////////////////////

//FUEQ Component:
FueqComponent::FueqComponent(Component& c) : FloatingArithmeticComponent(c){

	max_latency = 2;

	index = c.index;
	moduleName = "fcmp_ueq_op";
	name = c.name;
	instanceName =  name;
	type = c.type;
	bbID = c.bbID;
	op = c.op;
	in = c.in;
	out = c.out;
	delay = c.delay;
	latency = c.latency <= max_latency ? latency : max_latency;
	II = c.II;
	slots = c.slots;
	transparent = c.transparent;
	value = c.value;
	io = c.io;
	inputConnections = c.inputConnections;
	outputConnections = c.outputConnections;


	clk = c.clk;
	rst = c.rst;

	dsp48_uage = "No_Usage";
	add_sub = "Both";
	compare_operation = "Equal";
	operation_type = "Compare";
};

//FUNE Component:
FuneComponent::FuneComponent(Component& c) : FloatingArithmeticComponent(c){

	max_latency = 2;

	index = c.index;
	moduleName = "fcmp_une_op";
	name = c.name;
	instanceName =  name;
	type = c.type;
	bbID = c.bbID;
	op = c.op;
	in = c.in;
	out = c.out;
	delay = c.delay;
	latency = c.latency <= max_latency ? latency : max_latency;
	II = c.II;
	slots = c.slots;
	transparent = c.transparent;
	value = c.value;
	io = c.io;
	inputConnections = c.inputConnections;
	outputConnections = c.outputConnections;


	clk = c.clk;
	rst = c.rst;

	dsp48_uage = "No_Usage";
	add_sub = "Both";
	compare_operation = "Not_Equal";
	operation_type = "Compare";
};

//FUGT Component:
FugtComponent::FugtComponent(Component& c) : FloatingArithmeticComponent(c){

	max_latency = 2;

	index = c.index;
	moduleName = "fcmp_ugt_op";
	name = c.name;
	instanceName =  name;
	type = c.type;
	bbID = c.bbID;
	op = c.op;
	in = c.in;
	out = c.out;
	delay = c.delay;
	latency = c.latency <= max_latency ? latency : max_latency;
	II = c.II;
	slots = c.slots;
	transparent = c.transparent;
	value = c.value;
	io = c.io;
	inputConnections = c.inputConnections;
	outputConnections = c.outputConnections;


	clk = c.clk;
	rst = c.rst;

	dsp48_uage = "No_Usage";
	add_sub = "Both";
	compare_operation = "Greater_Than";
	operation_type = "Compare";
};

//FUGE Component:
FugeComponent::FugeComponent(Component& c) : FloatingArithmeticComponent(c){

	max_latency = 2;

	index = c.index;
	moduleName = "fcmp_uge_op";
	name = c.name;
	instanceName =  name;
	type = c.type;
	bbID = c.bbID;
	op = c.op;
	in = c.in;
	out = c.out;
	delay = c.delay;
	latency = c.latency <= max_latency ? latency : max_latency;
	II = c.II;
	slots = c.slots;
	transparent = c.transparent;
	value = c.value;
	io = c.io;
	inputConnections = c.inputConnections;
	outputConnections = c.outputConnections;


	clk = c.clk;
	rst = c.rst;

	dsp48_uage = "No_Usage";
	add_sub = "Both";
	compare_operation = "Greater_Than_Or_Equal";
	operation_type = "Compare";
};

//FULT Component:
FultComponent::FultComponent(Component& c) : FloatingArithmeticComponent(c){

	max_latency = 2;

	index = c.index;
	moduleName = "fcmp_ult_op";
	name = c.name;
	instanceName =  name;
	type = c.type;
	bbID = c.bbID;
	op = c.op;
	in = c.in;
	out = c.out;
	delay = c.delay;
	latency = c.latency <= max_latency ? latency : max_latency;
	II = c.II;
	slots = c.slots;
	transparent = c.transparent;
	value = c.value;
	io = c.io;
	inputConnections = c.inputConnections;
	outputConnections = c.outputConnections;


	clk = c.clk;
	rst = c.rst;

	dsp48_uage = "No_Usage";
	add_sub = "Both";
	compare_operation = "Less_Than";
	operation_type = "Compare";
};

//FULE Component:
FuleComponent::FuleComponent(Component& c) : FloatingArithmeticComponent(c){

	max_latency = 2;

	index = c.index;
	moduleName = "fcmp_ule_op";
	name = c.name;
	instanceName =  name;
	type = c.type;
	bbID = c.bbID;
	op = c.op;
	in = c.in;
	out = c.out;
	delay = c.delay;
	latency = c.latency <= max_latency ? latency : max_latency;
	II = c.II;
	slots = c.slots;
	transparent = c.transparent;
	value = c.value;
	io = c.io;
	inputConnections = c.inputConnections;
	outputConnections = c.outputConnections;


	clk = c.clk;
	rst = c.rst;

	dsp48_uage = "No_Usage";
	add_sub = "Both";
	compare_operation = "Less_Than_Or_Equal";
	operation_type = "Compare";
};


//FEXP Component:
FexpComponent::FexpComponent(Component& c) : FloatingArithmeticComponent(c){

	max_latency = 20;

	index = c.index;
	moduleName = "fexp_op";
	name = c.name;
	instanceName =  name;
	type = c.type;
	bbID = c.bbID;
	op = c.op;
	in = c.in;
	out = c.out;
	delay = c.delay;
	latency = c.latency <= max_latency ? latency : max_latency;
	II = c.II;
	slots = c.slots;
	transparent = c.transparent;
	value = c.value;
	io = c.io;
	inputConnections = c.inputConnections;
	outputConnections = c.outputConnections;


	clk = c.clk;
	rst = c.rst;

	dsp48_uage = "Medium_Usage";
	add_sub = "Both";
	compare_operation = "Programmable";
	operation_type = "Exponential";
};

//FLOG Component:
FlogComponent::FlogComponent(Component& c) : FloatingArithmeticComponent(c){

	max_latency = 22;

	index = c.index;
	moduleName = "flog_op";
	name = c.name;
	instanceName =  name;
	type = c.type;
	bbID = c.bbID;
	op = c.op;
	in = c.in;
	out = c.out;
	delay = c.delay;
	latency = c.latency <= max_latency ? latency : max_latency;
	II = c.II;
	slots = c.slots;
	transparent = c.transparent;
	value = c.value;
	io = c.io;
	inputConnections = c.inputConnections;
	outputConnections = c.outputConnections;


	clk = c.clk;
	rst = c.rst;

	dsp48_uage = "Medium_Usage";
	add_sub = "Both";
	compare_operation = "Programmable";
	operation_type = "Logarithm";
};

//FSQRT Component:
FsqrtComponent::FsqrtComponent(Component& c) : FloatingArithmeticComponent(c){

	max_latency = 28;

	index = c.index;
	moduleName = "fsqrt_op";
	name = c.name;
	instanceName =  name;
	type = c.type;
	bbID = c.bbID;
	op = c.op;
	in = c.in;
	out = c.out;
	delay = c.delay;
	latency = c.latency <= max_latency ? latency : max_latency;
	II = c.II;
	slots = c.slots;
	transparent = c.transparent;
	value = c.value;
	io = c.io;
	inputConnections = c.inputConnections;
	outputConnections = c.outputConnections;


	clk = c.clk;
	rst = c.rst;

	dsp48_uage = "No_Usage";
	add_sub = "Both";
	compare_operation = "Programmable";
	operation_type = "Square_root";
};

