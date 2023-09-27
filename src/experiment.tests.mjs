const fi = require("./expirement.mjs");

describe("experiment", () => {
    test("midpoint", () => {
        try {
            console.log(fi.midpoint("1", "2", fi.BASE_62_DIGITS))
        } catch (e) {
            console.log(e)
        }

        expect(1).toBe(1)
    })
})