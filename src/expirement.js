function inc(x, digits) {
    const [head, ...digs] = x.split("");
    let carry = true;

    for (let i = digs.length - 1; carry && i >= 0; i--) { // work down from rhs
        const d = digits.indexOf(digs[i]) + 1; // next digit index

        // console.log("d", d, "digs[i]" )

        if (d === digits.length) { // d is beyond last valid digit, so we want to carry, so keep going
            digs[i] = digits[0];
        } else {
            // d is still in digit range, so we are ok and change dig and stop
            digs[i] = digits[d];
            carry = false;
        }
    }

    return {
      carry,
      digs,
    }
}


// note that this may return null, as there is a largest integer
/**
 * @param {string} x
 * @param {string} digits
 * @return {string | null}
 */
function incrementInteger(x, digits) {
    validateInteger(x);
    const [head, ...digs] = x.split("");
    let carry = true;

    for (let i = digs.length - 1; carry && i >= 0; i--) { // work down from rhs
        const d = digits.indexOf(digs[i]) + 1; // next digit index

        // console.log("d", d, "digs[i]" )

        if (d === digits.length) { // d is beyond last valid digit, so we want to carry, so keep going
            digs[i] = digits[0];
        } else {
            // d is still in digit range, so we are ok and change dig and stop
            digs[i] = digits[d];
            carry = false;
        }
    }


    if (carry) {
        if (head === "Z") {
            return "a" + digits[0];
        }
        if (head === "z") {
            return null;
        }
        const h = String.fromCharCode(head.charCodeAt(0) + 1);
        if (h > "a") {
            digs.push(digits[0]);
        } else {
            digs.pop();
        }
        return h + digs.join("");
    } else {
        return head + digs.join("");
    }
}

/**
 * @param {string} int
 * @return {void}
 */

function validateInteger(int) {
  if (int.length !== getIntegerLength(int[0])) {
    throw new Error("invalid integer part of order key: " + int);
  }
}

// note that this may return null, as there is a smallest integer
/**
 * @param {string} x
 * @param {string} digits
 * @return {string | null}
 */

function decrementInteger(x, digits) {
    validateInteger(x);
    const [head, ...digs] = x.split("");
    let borrow = true;
    for (let i = digs.length - 1; borrow && i >= 0; i--) {
        const d = digits.indexOf(digs[i]) - 1;
        if (d === -1) {
            digs[i] = digits.slice(-1);
        } else {
            digs[i] = digits[d];
            borrow = false;
        }
    }
    if (borrow) {
        if (head === "a") {
            return "Z" + digits.slice(-1);
        }
        if (head === "A") {
            return null;
        }
        const h = String.fromCharCode(head.charCodeAt(0) - 1);
        if (h < "Z") {
            digs.push(digits.slice(-1));
        } else {
            digs.pop();
        }
        return h + digs.join("");
    } else {
        return head + digs.join("");
    }
}

/**
 * @param {string} head
 * @return {number}
 */

function getIntegerLength(head) {
    if (head >= "a" && head <= "z") {
        return head.charCodeAt(0) - "a".charCodeAt(0) + 2;
    } else if (head >= "A" && head <= "Z") {
        return "Z".charCodeAt(0) - head.charCodeAt(0) + 2;
    } else {
        throw new Error("invalid order key head: " + head);
    }
}

/**
 * @param {string} key
 * @return {string}
 */

function getIntegerPart(key) {
    const integerPartLength = getIntegerLength(key[0]);

    if (integerPartLength > key.length) {
        throw new Error("invalid order key: " + key);
    }
    return key.slice(0, integerPartLength);
}

/**
 * @param {string} key
 * @param {string} digits
 * @return {void}
 */

function validateOrderKey(key, digits) {
    if (key === "A" + digits[0].repeat(26)) {
        throw new Error("invalid order key: " + key);
    }
    // getIntegerPart will throw if the first character is bad,
    // or the key is too short.  we'd call it to check these things
    // even if we didn't need the result
    const i = getIntegerPart(key);

    const f = key.slice(i.length);


    if (f.slice(-1) === digits[0]) {
        throw new Error("invalid order key: " + key);
    }
}

const BASE_62_DIGITS = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";

// `a` may be empty string, `b` is null or non-empty string.
// `a < b` lexicographically if `b` is non-null.
// no trailing zeros allowed.
// digits is a string such as '0123456789' for base 10.  Digits must be in
// ascending character code order!
/**
 * @param {string} a
 * @param {string | null | undefined} b
 * @param {string} digits
 * @returns {string}
 */
function midpoint(a, b, digits) {
    const zero = digits[0];
    if (b != null && a >= b) {
        throw new Error(a + " >= " + b);
    }
    if (a.slice(-1) === zero || (b && b.slice(-1) === zero)) {
        throw new Error("trailing zero");
    }
    if (b) {
        // remove longest common prefix.  pad `a` with 0s as we
        // go.  note that we don't need to pad `b`, because it can't
        // end before `a` while traversing the common prefix.
        let n = 0;
        while ((a[n] || zero) === b[n]) {
            n++;
        }
        if (n > 0) {
            return b.slice(0, n) + midpoint(a.slice(n), b.slice(n), digits);
        }
    }

    // RLPT at this point strings do not have a common prefix

    // first digits (or lack of digit) are different
    const digitA = a ? digits.indexOf(a[0]) : 0;
    const digitB = b != null ? digits.indexOf(b[0]) : digits.length;
    if (digitB - digitA > 1) {
        const midDigit = Math.round(0.5 * (digitA + digitB));
        return digits[midDigit];
    } else {
        // first digits are consecutive
        if (b && b.length > 1) {
            const out = b.slice(0, 1);

            return out;
        } else {
            // `b` is null or has length 1 (a single digit).
            // the first digit of `a` is the previous digit to `b`,
            // or 9 if `b` is null.
            // given, for example, midpoint('49', '5'), return
            // '4' + midpoint('9', null), which will become
            // '4' + '9' + midpoint('', null), which is '495'
            return digits[digitA] + midpoint(a.slice(1), null, digits);
        }
    }
}

// midpoint("1", null, BASE_62_DIGITS)

module.exports = {
    BASE_62_DIGITS,
    midpoint,
    getIntegerPart,
    validateOrderKey,
    getIntegerLength,
    incrementInteger,
    decrementInteger,
    validateInteger,
    inc,
};
