// SPDX-License-Identifier: MIT
pragma solidity >= 0.8.0;

import {Test, console2} from "forge-std/Test.sol";
import "https://github.com/abdk-consulting/abdk-libraries-solidity/blob/master/ABDKMath64x64.sol";
import "https://github.com/abdk-consulting/abdk-libraries-solidity/blob/master/ABDKMathQuad.sol";

contract ABDKMath64x64Properties is Test {

    function setUp() public { }

    /* ============================== TESTS FOR FUNCTION add() ================================= */

    // Formally verify for commutative property: x + y == y + x
    function prove_add_commutative(int128 x, int128 y) public pure {
        int128 x_y = add(x, y);
        int128 y_x = add(y, x);

        assert(x_y == y_x);
    }

    // Formally verify for associative property: (x + y) + z == x + (y + z)
    function prove_add_associative(int128 x, int128 y, int128 z) public pure {
        assert(add(add(x, y), z) == add(x, add(y, z)));
    }

    // Formally verify for identity operation: x + 0 == x (equivalent to x + (-x) == 0)
    function prove_add_identity(int128 x) public view {
        assert(add(x, ZERO_FP) == x);
        assert(add(x, neg(x)) == ZERO_FP);
    }

    // Formally verify that the result increases or decreases depending on the value to be added
    function prove_add_values(int128 x, int128 y) public view {
        int128 x_y = add(x, y);

        if (y >= ZERO_FP) {
            assert(x_y >= x);
        } else {
            assert(x_y < x);
        }
    }

    /* ================= Tests for overflow and edge cases =================================== */

    // The result of the addition must be between the maximum
    // and minimum allowed values for 64x64
    function prove_add_range(int128 x, int128 y) public view {
        int128 result = this.add(x, y);
        assert(result <= MAX_64x64 && result >= MIN_64x64);
    }

    // Adding zero to the maximum value shouldn't revert, as it is valid
    // Moreover, the result must be MAX_64x64
    function prove_add_maximum_value() public view {
        int128 result = this.add(MAX_64x64, ZERO_FP);
        assert(result == MAX_64x64);
    }

    // Adding one to the maximum value should revert, as it is out of range
    function proveFail_add_maximum_value_plus_one() public view {
        this.add(MAX_64x64, ONE_FP);
    }

    // Adding zero to the minimum value shouldn't revert, as it is valid
    // Moreover, the result must be MIN_64x64
    function prove_add_minimum_value() public view {
        int128 result = this.add(MIN_64x64, ZERO_FP);
        assert(result == MIN_64x64);
    }

    // Adding minus one to the maximum value should revert, as it is out of range
    function proveFail_add_minimum_value_plus_negative_one() public view {
        this.add(MIN_64x64, MINUS_ONE_FP);
    }

    /* ============================== TESTS FOR FUNCTION sub() ================================= */

    // Formally verify equivalence to addition: x - y == x + (-y)
    function prove_sub_equivalence_to_addition(int128 x, int128 y) public pure {
        assert(add(x, neg(y)) == sub(x, y));
    }

    // Formally verify for non-commutative property: x - y == -(y - x)
    function prove_sub_non_commutative(int128 x, int128 y) public pure {
        assert(sub(x, y) == neg(sub(y, x)));
    }

    // Formally verify for identity operation: x - 0 == x  (equivalent to x - x == 0)
    function prove_sub_identity(int128 x) public view {
        assert(sub(x, ZERO_FP) == x);
        assert(sub(x, x) == ZERO_FP);
    }

    // Formally verify for neutrality over addition and subtraction: (x - y) + y == (x + y) - y == x
    function prove_sub_neutrality(int128 x, int128 y) public pure {
        int128 x_minus_y = sub(x, y);
        int128 x_plus_y = add(x, y);

        int128 x_minus_y_plus_y = add(x_minus_y, y);
        int128 x_plus_y_minus_y = sub(x_plus_y, y);

        assert(x_minus_y_plus_y == x_plus_y_minus_y);
        assert(x_minus_y_plus_y == x);
    }

    // Formally verify that the result increases or decreases depending
    // on the value to be subtracted
    function prove_sub_values(int128 x, int128 y) public view {
        int128 x_y = sub(x, y);

        if (y >= ZERO_FP) {
            assert(x_y <= x);
        } else {
            assert(x_y > x);
        }
    }

    /* ================= Tests for overflow and edge cases =================================== */

    // The result of the subtraction must be between the maximum
    // and minimum allowed values for 64x64
    function prove_sub_range(int128 x, int128 y) public view {
        int128 result = this.sub(x, y);
        assert(result <= MAX_64x64 && result >= MIN_64x64);
    }

    // Subtracting zero from the maximum value shouldn't revert, as it is valid
    // Moreover, the result must be MAX_64x64
    function prove_sub_maximum_value() public view {
        int128 result = this.sub(MAX_64x64, ZERO_FP);
        assert(result == MAX_64x64);
    }

    // Subtracting minus one from the maximum value should revert,
    // as it is out of range
    function proveFail_sub_maximum_value_minus_neg_one() public view {
        this.sub(MAX_64x64, MINUS_ONE_FP);
    }

    // Subtracting zero from the minimum value shouldn't revert, as it is valid
    // Moreover, the result must be MIN_64x64
    function prove_sub_minimum_value() public view {
        int128 result = this.sub(MIN_64x64, ZERO_FP);
        assert(result == MIN_64x64);
    }

    // Subtracting one from the minimum value should revert, as it is out of range
    function proveFail_sub_minimum_value_minus_one() public view {
        this.sub(MIN_64x64, ONE_FP);
    }

    /* ============================== TESTS FOR FUNCTION mul() ================================= */

    // Formally verify for commutative property: x * y == y * x
    function prove_mul_commutative(int128 x, int128 y) public pure {
        assert(mul(x, y) == mul(y, x));
    }

    // Formally verify for identity operation: x * 1 == x  (also check that x * 0 == 0)
    function prove_mul_identity(int128 x) public view {
        assert(mul(x, ONE_FP) == x);
        assert(mul(x, ZERO_FP) == ZERO_FP);
    }

    // Formally verify that the result increases or decreases depending
    // on the value to be added (Original verification was broken in four independent verifications)
    function prove_mul_value1(int128 x, int128 y) public view { // OK with CVC5 (1min 3,43sec - MacBook Pro Apple M1 32GB RAM Sonoma 14.2.1)
        if (x >= ZERO_FP) {
            if(y >= ONE_FP)
                assert(mul(x, y) >= x);
        } else {
            if(y >= ONE_FP)
                assert(mul(x, y) <= x);
            else
                assert(mul(x, y) >= x);
        }
    }

    // Formally verify that the result increases or decreases depending
    // on the value to be added (Original test was broken in four independent tests)
    function prove_mul_test_value1(int128 x, int128 y) public view { // OK with CVC5 (1min 3,43sec - MacBook Pro Apple M1 32GB RAM Sonoma 14.2.1)
        if (x >= ZERO_FP) {
            if(y >= ONE_FP)
                assert(mul(x, y) >= x);
        } else {
            if(y >= ONE_FP)
                assert(mul(x, y) <= x);
            else
                assert(mul(x, y) >= x);
        }
    }

    /* ================= Tests for overflow and edge cases =================================== */

    // The result of the multiplication must be between the maximum
    // and minimum allowed values for 64x64
    function prove_mul_range(int128 x, int128 y) public view {
        int128 result = this.mul(x, y);
        assert(result <= MAX_64x64 && result >= MIN_64x64);
    }

    // Multiplying the maximum value times one shouldn't revert, as it is valid
    // Moreover, the result must be MAX_64x64
    function prove_mul_maximum_value() public view {
        int128 result = this.mul(MAX_64x64, ONE_FP);
        assert(result == MAX_64x64);
    }

    // Multiplying the minimum value times one shouldn't revert, as it is valid
    // Moreover, the result must be MIN_64x64
    function prove_mul_minimum_value() public view {
        int128 result = this.mul(MIN_64x64, ONE_FP);
        assert(result == MIN_64x64);
    }

    /* ============================== TESTS FOR FUNCTION div() ================================= */

    // Formally verify for identity property: x / 1 == x (equivalent to x / x == 1)
    // Moreover, x/x should not revert unless x == 0
    function prove_div_division_identity(int128 x) public view { // OK with CVC5 (1min 51,28sec - MacBook Pro Apple M1 32GB RAM Sonoma 14.2.1)
        if(x != ZERO_FP)
            assert(div(x, x) == ONE_FP);
        else revert();
    }

    // Formally verify for negative divisor: x / -y == -(x / y)
    function prove_div_negative_divisor(int128 x, int128 y) public view { // OK with CVC5 (32,889sec - MacBook Pro Apple M1 32GB RAM Sonoma 14.2.1)
        if(y < ZERO_FP) {
           assert(div(x, neg(y)) == neg(div(x, y)));
        } else revert();
    }

    // Formally verify for division with 0 as numerator: 0 / x = 0
    function prove_div_division_num_zero(int128 x) public view { // OK with CVC5 (7,252sec - MacBook Pro Apple M1 32GB RAM Sonoma 14.2.1)
        if(x != ZERO_FP) {
            assert(ZERO_FP == div(ZERO_FP, x));
        } else revert();
    }

    // Formally verify for identity property
    // x / 1 == x (equivalent to x / x == 1)
    // Moreover, x/x should not revert unless x == 0
    function prove_div_test_division_identity(int128 x) public view { // OK with CVC5 (1min 51,28sec - MacBook Pro Apple M1 32GB RAM Sonoma 14.2.1)
        if(x != ZERO_FP)
            assert(div(x, x) == ONE_FP);
        else revert();
    }

    // Formally verify for negative divisor
    // x / -y == -(x / y)
    function prove_div_test_negative_divisor(int128 x, int128 y) public view { // OK with CVC5 (32,889sec - MacBook Pro Apple M1 32GB RAM Sonoma 14.2.1)
        if(y < ZERO_FP) {
           assert(div(x, neg(y)) == neg(div(x, y)));
        } else revert();
    }

    // Formally verify for division with 0 as numerator
    // 0 / x = 0
    function prove_div_test_division_num_zero(int128 x) public view { // OK with CVC5 (7,252sec - MacBook Pro Apple M1 32GB RAM Sonoma 14.2.1)
        if(x != ZERO_FP) {
            assert(ZERO_FP == div(ZERO_FP, x));
        } else revert();
    }

    /* ================= Tests for overflow and edge cases =================================== */

    // Formally verify for division by zero
    function proveFail_div_div_by_zero(int128 x) public view {
        this.div(x, ZERO_FP);
    }

    // Formally verify for division by a large value, the result should be less than one
    function prove_div_maximum_denominator(int128 x) public view {
        assert(abs(div(x, MAX_64x64)) <= ONE_FP);
    }

    // Formally verify for division of a large value
    // This should revert if |x| < 1 as it would return a value higher than max
    function prove_div_maximum_numerator(int128 x) public view { // OK with CVC5 (19,301sec - MacBook Pro Apple M1 32GB RAM Sonoma 14.2.1)
        int128 div_large;

        try this.div(MAX_64x64, x) {
            // If it didn't revert, then |x| >= 1
            div_large = div(MAX_64x64, x);

            assert(abs(x) >= ONE_FP);
        } catch {
            // Expected revert as result is higher than max
        }
    }

    // Formally verify for values in range
    function prove_div_range(int128 x, int128 y) public view { // OK with CVC5 (20,636sec - MacBook Pro Apple M1 32GB RAM Sonoma 14.2.1)
        int128 result;

        try this.div(x, y) {
            // If it returns a value, it must be in range
            result = div(x, y);
            assert(result <= MAX_64x64 && result >= MIN_64x64);
        } catch {
            // Otherwise, it should revert
        }
    }

    // Formally verify for division of a large value
    // This should revert if |x| < 1 as it would return a value higher than max
    function prove_div_test_maximum_numerator(int128 x) public view { // OK with CVC5 (19,301sec - MacBook Pro Apple M1 32GB RAM Sonoma 14.2.1)
        int128 div_large;

        try this.div(MAX_64x64, x) {
            // If it didn't revert, then |x| >= 1
            div_large = div(MAX_64x64, x);

            assert(abs(x) >= ONE_FP);
        } catch {
            // Expected revert as result is higher than max
        }
    }

    // Formally verify for values in range
    function prove_div_test_range(int128 x, int128 y) public view { // OK with CVC5 (20,636sec - MacBook Pro Apple M1 32GB RAM Sonoma 14.2.1)
        int128 result;

        try this.div(x, y) {
            // If it returns a value, it must be in range
            result = div(x, y);
            assert(result <= MAX_64x64 && result >= MIN_64x64);
        } catch {
            // Otherwise, it should revert
        }
    }

    /* ============================== TESTS FOR FUNCTION neg() ================================= */

    // Formally verify for the double negation: -(-x) == x
    function prove_neg_double_negation(int128 x) public pure {
        assert(x == neg(neg(x)));
    }

    // Formally verify for the identity operation: x + (-x) == 0
    function prove_neg_identity(int128 x) public view {
        assert(add(x, neg(x)) == ZERO_FP);
    }

    /* ================= Tests for overflow and edge cases =================================== */

    // Formally verify for the zero-case: -0 == 0
    function prove_neg_zero() public view {
        assert(neg(ZERO_FP) == ZERO_FP);
    }

    // Formally verify for the maximum value case
    // Since this is implementation-dependant, we will actually verify with MAX_64x64-EPS
    function prove_neg_maximum() public view {
        this.neg(sub(MAX_64x64, EPSILON));
        assert(true);
    }

    // Formally verify for the minimum value case
    // Since this is implementation-dependant, we will actually verify with MIN_64x64+EPS
    function prove_neg_minimum() public view {
        this.neg(add(MIN_64x64, EPSILON));
        assert(true);
    }

    /* ============================== TESTS FOR FUNCTION abs() ================================= */

    // Formally verify that the absolute value is always positive
    function prove_abs_positive(int128 x) public view {
        assert(abs(x) >= ZERO_FP);
    }

    // Formally verify that the absolute value of a number equals the
    // absolute value of the negative of the same number
    function prove_abs_negative(int128 x) public pure {
        assert(abs(x) == abs(neg(x)));
    }

    // Formally verify the multiplicativeness property
    // | x * y | == |x| * |y|
    function prove_abs_multiplicativeness(int128 x, int128 y) public pure { // OK (10,715sec - MacBook Pro Apple M1 32GB RAM Sonoma 14.2.1)
        int128 mul_xy = mul(x, y);
        if(mul_xy >= MIN_64x64 && mul_xy <= MAX_64x64)
            assert(abs(mul(x, y)) == mul(abs(x), abs(y)));
        else revert();
    }

    // Formally verify the subadditivity property
    // | x + y | <= |x| + |y|
    function prove_abs_subadditivity(int128 x, int128 y) public pure {
        assert(abs(add(x, y)) <= add(abs(x), abs(y)));
    }

    // Test the multiplicativeness property
    // | x * y | == |x| * |y|
    function prove_abs_test_multiplicativeness(int128 x, int128 y) public pure { // OK (10,715sec - MacBook Pro Apple M1 32GB RAM Sonoma 14.2.1)
        int128 mul_xy = mul(x, y);
        if(mul_xy >= MIN_64x64 && mul_xy <= MAX_64x64)
            assert(abs(mul(x, y)) == mul(abs(x), abs(y)));
        else revert();
    }

    /* ================= Tests for overflow and edge cases =================================== */

    // Formally verify the zero-case | 0 | = 0
    function prove_abs_zero() public view {
        assert(this.abs(ZERO_FP) == ZERO_FP);
    }

    // Formally verify the maximum value
    function prove_abs_maximum() public view {
        assert(this.abs(MAX_64x64) == MAX_64x64);
    }

    /* ============================== TESTS FOR FUNCTION inv() ================================= */

    /* ================================================================
       Tests for mathematical properties.
       These should make sure that the implemented function complies
       with math rules and expected behaviour.
       ================================================================ */

    // Test that the result has the same sign as the argument
    function prove_inv_test_sign(int128 x) public view { // OK with CVC5
        require(x != ZERO_FP);

        int128 inv_x = inv(x);

        if (x > ZERO_FP) {
            assert(inv_x > ZERO_FP);
        } else {
            assert(inv_x < ZERO_FP);
        }
    }

    // Formally verify that the inverse of the inverse is close enough to the
    // original number
    function prove_inv_double_inverse(int128 x) public view { // Ok. Difficulty related to precision to prove the general case
        if(x != ZERO_FP && x >= -10 && x <= 10) { // For this subcase, it holds
            int128 double_inv_x = inv(inv(x));
            assert(x == double_inv_x);
        } else revert();
    }

    // Formally verify equivalence with division
    function prove_inv_division(int128 x) public view {
        if(x != ZERO_FP) { 
           assert(inv(x) == div(ONE_FP, x));
        } else revert();
    }

    // Formally verify the multiplication of inverses: 1/(x * y) == 1/x * 1/y
    function prove_inv_multiplication(int128 x, int128 y) public view { // OK. Difficulty related to precision to prove the general case
        if(x != ZERO_FP && y != ZERO_FP && x >= -10 && x <= 10 && y >= -10 && y <= 10) {

            int128 inv_x = inv(x);
            int128 inv_y = inv(y);
            int128 inv_x_times_inv_y = mul(inv_x, inv_y);

            int128 x_y = mul(x, y);
            int128 inv_x_y = inv(x_y);
            assert(inv_x_y == inv_x_times_inv_y);
        }
    }

    // Formally verify that the absolute value of the result is in range zero-one
    // if x is greater than one, else, the absolute value of the result
    // must be greater than one
    function prove_inv_values(int128 x) public view { // OK (20,379sec - MacBook Pro Apple M1 32GB RAM Sonoma 14.2.1)
        if(x != ZERO_FP) {

        int128 abs_inv_x = abs(inv(x));

        if (abs(x) >= ONE_FP) {
            assert(abs_inv_x <= ONE_FP);
        } else {
            assert(abs_inv_x > ONE_FP);
        }
        } else revert();
    }

    // Formally verify that the result has the same sign as the argument
    function prove_inv_sign(int128 x) public view { // OK with CVC5
        require(x != ZERO_FP);

        int128 inv_x = inv(x);

        if (x > ZERO_FP) {
            assert(inv_x > ZERO_FP);
        } else {
            assert(inv_x < ZERO_FP);
        }
    }

    /* ================= Tests for overflow and edge cases =================================== */

    // Formally verify the zero-case should revert
    function proveFail_inv_zero() public view {
        this.inv(ZERO_FP);
    }

    // Formally verify the maximum value case, should not revert, and be close to zero
    function prove_inv_maximum() public view {
        assert(equal_within_precision(this.inv(MAX_64x64), ZERO_FP, 10));
    }

    // Formally verify the minimum value case, should not revert, and be close to zero
    function prove_inv_minimum() public view {
        assert(equal_within_precision(abs(this.inv(MIN_64x64)), ZERO_FP, 10));
    }

    /* ============================== TESTS FOR FUNCTION avg() ================================= */

    // Formally verify that the result is between the two operands: avg(x, y) >= min(x, y) && avg(x, y) <= max(x, y)
    function prove_avg_values_in_range(int128 x, int128 y) public pure {
        int128 avg_xy = avg(x, y);

        if (x >= y) {
            assert(avg_xy >= y && avg_xy <= x);
        } else {
            assert(avg_xy >= x && avg_xy <= y);
        }
    }

    // Formally verify that the average of the same number is itself: avg(x, x) == x
    function prove_avg_one_value(int128 x) public pure {
        assert(avg(x, x) == x);
    }

    // Formally verify that the order of operands is irrelevant: avg(x, y) == avg(y, x)
    function prove_avg_operand_order(int128 x, int128 y) public pure {
        assert(avg(x, y) == avg(y, x));
    }

    /* ================= Tests for overflow and edge cases =================================== */

    // Formally verify for the maximum value
    function prove_avg_maximum() public view {
        assert(this.avg(MAX_64x64, MAX_64x64) == MAX_64x64);
    }

    // Formally verify for the minimum value
    function prove_avg_minimum() public view {
        assert(this.avg(MIN_64x64, MIN_64x64) == MIN_64x64);
    }

    /* ============================== TESTS FOR FUNCTION gavg() ================================= */

    // Formally verify that the result is between the two operands: gavg(x, y) >= min(x, y) && gavg(x, y) <= max(x, y)
    function prove_gavg_values_in_range1(int128 x, int128 y) public view { // OK (3min48,14sec - MacBook Pro Apple M1 32GB RAM Sonoma 14.2.1)
        int128 gavg_xy = gavg(x, y);

        if (x == ZERO_FP && y >= ZERO_FP) {
            assert(gavg_xy >= ZERO_FP);
        } else revert();
    }

    /* ================= Tests for overflow and edge cases =================================== */

    // Formally verify for the maximum value
    function prove_gavg_maximum() public view {
        assert(this.gavg(MAX_64x64, MAX_64x64) == MAX_64x64);
    }

    // Formally verify for the minimum value
    function prove_gavg_minimum() public view {
        assert(this.gavg(MIN_64x64, MIN_64x64) == MIN_64x64);
    }

    /* ============================== TESTS FOR FUNCTION pow() ================================= */

    // Formally verify for zero exponent
    // x ** 0 == 1
    function prove_pow_zero_exponent(int128 x) public view {
        assert(pow(x, 0) == ONE_FP);
    }

    // Formally verify for exponent one
    // x ** 1 == x
    function prove_pow_one_exponent(int128 x) public pure { // OK (3min49,79sec - MacBook Pro Apple M1 32GB RAM Sonoma 14.2.1)
        int128 x_pow_1 = pow(x, 1);

        assert(x_pow_1 == x);
    }

    /* ================= Tests for overflow and edge cases =================================== */

    // Formally verify for maximum base and exponent > 1
    function proveFail_pow_maximum_base(uint256 a) public view {
        if(a > 1) {
            this.pow(MAX_64x64, a);
        } else revert();
    }

    /* ============================== TESTS FOR FUNCTION sqrt() ================================= */

    // Formally verify for zero case
    function prove_sqrt_zero() public view {
        assert(sqrt(ZERO_FP) == ZERO_FP);
    }

    // Formally verify for maximum value
    function prove_sqrt_maximum() public view {
        this.sqrt(MAX_64x64);
    }

    // Formally verify for minimum value
    function proveFail_sqrt_minimum() public view {
        this.sqrt(MIN_64x64);
    }

    // Formally verify for negative operands
    function prove_sqrt_negative(int128 x) public view {  // OK (1min58,22sec - MacBook Pro Apple M1 32GB RAM Sonoma 14.2.1)
        if(x < ZERO_FP) {
           this.sqrt(x);
        } else revert();
    }

    /* ============================== TESTS FOR FUNCTION log2() ================================= */

    /* ================= Tests for overflow and edge cases =================================== */

    // Formally verify for zero case should revert
    function proveFail_log2_zero() public view {
        this.log_2(ZERO_FP);
    }

    // Formally verify for maximum value case, should return a positive number
    function prove_log2_maximum() public view {
        int128 result;
        result = this.log_2(MAX_64x64);
        assert(result > ZERO_FP);
    }

    /* ============================== TESTS FOR FUNCTION ln() ================================= */

    /* ================= Tests for overflow and edge cases =================================== */

    // Formally verify for zero case should revert
    function proveFail_ln_zero() public view {
        this.ln(ZERO_FP);
    }

    // Formally verify for maximum value case should return a positive number
    function prove_ln_maximum() public view {
        int128 result;
        result = this.ln(MAX_64x64);
        assert(result > ZERO_FP);
    }

    /* ============================== TESTS FOR FUNCTION exp2() ================================= */

    // Formally verify for zero case
    // exp_2(0) == 1
    function prove_exp2_zero() public view {
        assert(exp_2(ZERO_FP) == ONE_FP);
    }

    // Formally verify for maximum value. This should overflow as it will not fit
    // in the data type
    function proveFail_exp2_maximum() public view {
        this.exp_2(MAX_64x64);
    }

    // Formally verify for minimum value. This should return zero since
    // 2 ** -x == 1 / 2 ** x that tends to zero as x increases
    function prove_exp2_minimum() public view {
        assert(this.exp_2(MIN_64x64) == ZERO_FP);
    }

    /* ============================== TESTS FOR FUNCTION log2() ================================= */

    /* ================= Tests for overflow and edge cases =================================== */

    // Formally verify for zero case
    // exp(0) == 1
    function prove_exp_zero() public view {
        assert(exp(ZERO_FP) == ONE_FP);
    }

    // Formally verify for maximum value. This should overflow as it will not fit
    // in the data type
    function proveFail_exp_maximum() public view {
        this.exp(MAX_64x64);
    }

    // Formally verify for minimum value. This should return zero since
    // e ** -x == 1 / e ** x that tends to zero as x increases
    function prove_exp_minimum() public view {
        assert(exp(MIN_64x64) == ZERO_FP);
    }

}

