#include <math.h>

int dynamatic_intmul(int a, int b){
#pragma HLS inline off
	return a*b;
}

int dynamatic_fcmp_oeq(float a, float b){
#pragma HLS inline off
	return a == b;
}

int dynamatic_fcmp_ogt(float a, float b){
#pragma HLS inline off
	return a > b;
}

int dynamatic_fcmp_oge(float a, float b){
#pragma HLS inline off
	return a >= b;
}

int dynamatic_fcmp_olt(float a, float b){
#pragma HLS inline off
	return a < b;
}

int dynamatic_fcmp_ole(float a, float b){
#pragma HLS inline off
	return a <= b;
}

int dynamatic_fcmp_one(float a, float b){
#pragma HLS inline off
	return a != b;
}

float dynamatic_fadd(float a, float b){
#pragma HLS inline off
	return a + b;
}

float dynamatic_fsub(float a, float b){
#pragma HLS inline off
	return a - b;
}

float dynamatic_fmul(float a, float b){
#pragma HLS inline off
	return a * b;
}

float dynamatic_fdiv(float a, float b){
#pragma HLS inline off
	return a/b;
}

int dynamatic_udiv(unsigned int a, unsigned int b){
#pragma HLS inline off
	return a/b;
}

int dynamatic_sdiv(int a, int b){
#pragma HLS inline off
	return a/b;
}

int dynamatic_urem(unsigned a, unsigned b){
#pragma HLS inline off
	return a%b;
}

int dynamatic_srem(int a, int b){
#pragma HLS inline off
	return a%b;
}

float dynamatic_roundf(float a){
#pragma HLS inline off
	return roundf(a);
}

float dynamatic_ceilf(float a){
#pragma HLS inline off
	return ceilf(a);
}

float dynamatic_floorf(float a){
#pragma HLS inline off
	return floorf(a);
}

float dynamatic_sitofp(int a) {
#pragma HLS inline off
	return (float) a;
}

float dynamatic_sinf(float a) {
#pragma HLS inline off
	return sinf(a);
}

float dynamatic_cosf(float a) {
#pragma HLS inline off
	return cosf(a);
}

float dynamatic_sqrtf(float a) {
#pragma HLS inline off
	return sqrtf(a);
}

float dynamatic_expf(float a) {
#pragma HLS inline off
	return expf(a);
}

float dynamatic_exp2f(float a) {
#pragma HLS inline off
	return exp2f(a);
}

float dynamatic_logf(float a) {
#pragma HLS inline off
	return logf(a);
}

float dynamatic_log2f(float a) {
#pragma HLS inline off
	return log2f(a);
}

float dynamatic_log10f(float a) {
#pragma HLS inline off
	return log10f(a);
}

float dynamatic_fabsf(float a) {
#pragma HLS inline off
	return fabsf(a);
}

float dynamatic_truncf(float a) {
#pragma HLS inline off
	return truncf(a);
}

float dynamatic_fminf(float a, float b){
#pragma HLS inline off
	return fminf(a, b);
}

float dynamatic_fmaxf(float a, float b){
#pragma HLS inline off
	return fmaxf(a, b);
}

float dynamatic_powf(float a, float b){
#pragma HLS inline off
	return powf(a, b);
}

float dynamatic_copysignf(float a, float b){
#pragma HLS inline off
	return copysignf(a, b);
}

void dynamatic_units_6ns (int a[10], int b[10], int c[10], float d[10], float e[10], float f[10] ) {
	int i;

	// int mul
	for (i = 0; i < 10; i++) {
#pragma HLS pipeline
#pragma HLS inline off
		c[i] = dynamatic_intmul (a[i], b[i]);
	}

	// fcmp oeq
	for (i = 0; i < 10; i++) {
#pragma HLS pipeline
#pragma HLS inline off
		f[i] = dynamatic_fcmp_oeq (e[i], d[i]);
	}

	// fcmp ogt
	for (i = 0; i < 10; i++) {
#pragma HLS pipeline
#pragma HLS inline off
		f[i] = dynamatic_fcmp_ogt (e[i], d[i]);
	}

	// fcmp oge
	for (i = 0; i < 10; i++) {
#pragma HLS pipeline
#pragma HLS inline off
		f[i] = dynamatic_fcmp_oge (e[i], d[i]);
	}

	// fcmp olt
	for (i = 0; i < 10; i++) {
#pragma HLS pipeline
#pragma HLS inline off
		f[i] = dynamatic_fcmp_olt (e[i], d[i]);
	}

	// fcmp ole
	for (i = 0; i < 10; i++) {
#pragma HLS pipeline
#pragma HLS inline off
		f[i] = dynamatic_fcmp_ole (e[i], d[i]);
	}

	// fcmp one
	for (i = 0; i < 10; i++) {
#pragma HLS pipeline
#pragma HLS inline off
		f[i] = dynamatic_fcmp_one (e[i], d[i]);
	}

	// fadd
	for (i = 0; i < 10; i++) {
#pragma HLS pipeline
#pragma HLS inline off
		f[i] = dynamatic_fadd (e[i], d[i]);
	}

	// fsub
	for (i = 0; i < 10; i++) {
#pragma HLS pipeline
#pragma HLS inline off
		f[i] = dynamatic_fsub (e[i], d[i]);
	}

	// fmul
	for (i = 0; i < 10; i++) {
#pragma HLS pipeline
#pragma HLS inline off
		f[i] = dynamatic_fmul (e[i], d[i]);
	}

	//udiv
	for (i = 0; i < 10; i++) {
#pragma HLS pipeline
#pragma HLS inline off
		c[i] = dynamatic_udiv ((unsigned) a[i], (unsigned) b[i]);
	}

	// sdiv
	for (i = 0; i < 10; i++) {
#pragma HLS pipeline
#pragma HLS inline off
		c[i] = dynamatic_sdiv (a[i], b[i]);
	}

	// fdiv
	for (i = 0; i < 10; i++) {
#pragma HLS pipeline
#pragma HLS inline off
		f[i] = dynamatic_fdiv (e[i], d[i]);
	}

	// srem
	for (i = 0; i < 10; i++) {
#pragma HLS pipeline
#pragma HLS inline off
		c[i] = dynamatic_srem (a[i], b[i]);
	}

	// urem
	for (i = 0; i < 10; i++) {
#pragma HLS pipeline
#pragma HLS inline off
		c[i] = dynamatic_urem ((unsigned) a[i], (unsigned) b[i]);
	}

	// frem ??

	// sinf
	for (i = 0; i < 10; i++) {
#pragma HLS pipeline
#pragma HLS inline off
		f[i] = dynamatic_sinf(e[i]);
	}
	// cosf
	for (i = 0; i < 10; i++) {
#pragma HLS pipeline
#pragma HLS inline off
		f[i] = dynamatic_cosf(e[i]);
	}
	// sqrtf
	for (i = 0; i < 10; i++) {
#pragma HLS pipeline
#pragma HLS inline off
		f[i] = dynamatic_sqrtf(e[i]);
	}
	// expf
	for (i = 0; i < 10; i++) {
#pragma HLS pipeline
#pragma HLS inline off
		f[i] = dynamatic_expf(e[i]);
	}
	// exp2f
	for (i = 0; i < 10; i++) {
#pragma HLS pipeline
#pragma HLS inline off
		f[i] = dynamatic_exp2f(e[i]);
	}

	// logf
	for (i = 0; i < 10; i++) {
#pragma HLS pipeline
#pragma HLS inline off
		f[i] = dynamatic_logf(e[i]);
	}

	// log2f
	for (i = 0; i < 10; i++) {
#pragma HLS pipeline
#pragma HLS inline off
		f[i] = dynamatic_log2f(e[i]);
	}

	// log10f
	for (i = 0; i < 10; i++) {
#pragma HLS pipeline
#pragma HLS inline off
		f[i] = dynamatic_log10f(e[i]);
	}

	// fabsf
	for (i = 0; i < 10; i++) {
#pragma HLS pipeline
#pragma HLS inline off
		f[i] = dynamatic_fabsf(e[i]);
	}

	// truncf
	for (i = 0; i < 10; i++) {
#pragma HLS pipeline
#pragma HLS inline off
		f[i] = dynamatic_truncf(e[i]);
	}

	// floorf
	for (i = 0; i < 10; i++) {
#pragma HLS pipeline
#pragma HLS inline off
		f[i] = dynamatic_floorf(e[i]);
	}
	// ceilf
	for (i = 0; i < 10; i++) {
#pragma HLS pipeline
#pragma HLS inline off
		f[i] = dynamatic_ceilf(e[i]);
	}
	// roundf
	for (i = 0; i < 10; i++) {
#pragma HLS pipeline
#pragma HLS inline off
		f[i] = dynamatic_roundf (e[i]);
	}

	// fminf
	for (i = 0; i < 10; i++) {
#pragma HLS pipeline
#pragma HLS inline off
		f[i] = dynamatic_fminf (e[i], d[i]);
	}

	// fmaxf
	for (i = 0; i < 10; i++) {
#pragma HLS pipeline
#pragma HLS inline off
		f[i] = dynamatic_fmaxf (e[i], d[i]);
	}

	// powf
	for (i = 0; i < 10; i++) {
#pragma HLS pipeline
#pragma HLS inline off
		f[i] = dynamatic_powf (e[i], d[i]);
	}

	// copysignf
	for (i = 0; i < 10; i++) {
#pragma HLS pipeline
#pragma HLS inline off
		f[i] = dynamatic_copysignf (e[i], d[i]);
	}
	// sitofp
	for (i = 0; i < 10; i++) {
#pragma HLS pipeline
#pragma HLS inline off
		f[i] = dynamatic_sitofp(a[i]);
	}

}
//int a[10], int b[10], int c[10], float d[10], float e[10], float f[10]
int main() {
	int a[10], b[10], c[10];
	float d[10], e[10], f[10];

	for (int i = 0; i < 10; i ++) {
		a[i] = rand() % 100;
		b[i] = rand() % 100;
		c[i] = rand() % 100;
		d[i] = (float) (rand() % 100);
		e[i] = (float) (rand() % 100);
		f[i] = (float) (rand() % 100);
	}

	dynamatic_units_6ns(a, b, c, d, e, f);
	dynamatic_units_6ns(a, b, c, d, e, f);
}
